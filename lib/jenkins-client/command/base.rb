# heavily based on the Heroku client gem

require "fileutils"
require "jenkins-client/command"

module Jenkins
  class Client
    class Command
      class Base
        include Jenkins::Client::Helpers

        def self.namespace
          self.to_s.split("::").last.downcase
        end

        attr_reader :args
        attr_reader :options

        def initialize(args=[], options={})
          @args = args
          @options = options
        end

      protected

        def self.inherited(klass)
          return if klass == Jenkins::Client::Command::Base

          help = extract_help_from_caller(caller.first)

          Jenkins::Client::Command.register_namespace(
            :name => klass.namespace,
            :description => help.split("\n").first
          )
        end

        def self.method_added(method)
          return if self == Jenkins::Client::Command::Base
          return if private_method_defined?(method)
          return if protected_method_defined?(method)

          help = extract_help_from_caller(caller.first)
          resolved_method = (method.to_s == "index") ? nil : method.to_s
          command = [ self.namespace, resolved_method ].compact.join(":")
          banner = extract_banner(help) || command
          permute = !banner.index("*")
          banner.gsub!("*", "")

          Jenkins::Client::Command.register_command(
            :klass       => self,
            :method      => method,
            :namespace   => self.namespace,
            :command     => command,
            :banner      => banner,
            :help        => help,
            :summary     => extract_summary(help),
            :description => extract_description(help),
            :options     => extract_options(help),
            :permute     => permute
          )
        end

        def self.alias_command(new, old)
          raise "no such command: #{old}" unless Jenkins::Client::Command.commands[old]
          Jenkins::Client::Command.command_aliases[new] = old
        end

        #
        # Parse the caller format and identify the file and line number as identified
        # in : http://www.ruby-doc.org/core/classes/Kernel.html#M001397.  This will
        # look for a colon followed by a digit as the delimiter.  The biggest
        # complication is windows paths, which have a color after the drive letter.
        # This regex will match paths as anything from the beginning to a colon
        # directly followed by a number (the line number).
        #
        # Examples of the caller format :
        # * c:/Ruby192/lib/.../lib/heroku/command/addons.rb:8:in `<module:Command>'
        # * c:/Ruby192/lib/.../heroku-2.0.1/lib/heroku/command/pg.rb:96:in `<class:Pg>'
        # * /Users/ph7/...../xray-1.1/lib/xray/thread_dump_signal_handler.rb:9
        #
        def self.extract_help_from_caller(line)
          # pull out of the caller the information for the file path and line number
          if line =~ /^(.+?):(\d+)/
            return extract_help($1, $2)
          end
          raise "unable to extract help from caller: #{line}"
        end

        def self.extract_help(file, line)
          buffer = []
          lines  = File.read(file).split("\n")

          catch(:done) do
            (line.to_i-2).downto(0) do |i|
              case lines[i].strip[0..0]
                when "", "#" then buffer << lines[i]
                else throw(:done)
              end
            end
          end

          buffer.map! do |line|
            line.strip.gsub(/^#/, "")
          end

          buffer.reverse.join("\n").strip
        end

        def self.extract_banner(help)
          help.split("\n").first
        end

        def self.extract_summary(help)
          extract_description(help).split("\n").first
        end

        def self.extract_description(help)
          lines = help.split("\n").map { |l| l.strip }
          lines.shift
          lines.reject do |line|
            line =~ /^-(.+)#(.+)/
          end.join("\n").strip
        end

        def self.extract_options(help)
          help.split("\n").map { |l| l.strip }.select do |line|
            line =~ /^-(.+)#(.+)/
          end.inject({}) do |hash, line|
            description = line.split("#", 2).last.strip
            long  = line.match(/--([A-Za-z\- ]+)/)[1].strip
            short = line.match(/-([A-Za-z ])/)[1].strip
            hash.update(long.split(" ").first => { :desc => description, :short => short, :long => long })
          end
        end

        def extract_option(name, default=true)
          key = name.gsub("--", "").to_sym
          return unless options[key]
          value = options[key] || default
          block_given? ? yield(value) : value
        end
        
      end
    end
  end
end

