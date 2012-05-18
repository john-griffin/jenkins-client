# heavily based on the Heroku client gem

module Jenkins
  class Client
    module Helpers
    
      def display(msg)
        STDOUT.puts(msg)
      end
      
      def error(msg)
        STDERR.puts(msg)
        exit 1
      end

      def longest(items)
        items.map { |i| i.to_s.length }.sort.last
      end

      def home_directory
        running_on_windows? ? ENV['USERPROFILE'].gsub("\\","/") : ENV['HOME']
      end

      def running_on_windows?
        RUBY_PLATFORM =~ /mswin32|mingw32/
      end

      def running_on_a_mac?
        RUBY_PLATFORM =~ /-darwin\d/
      end

      def ask
        STDIN.gets.strip
      end
      
      def with_tty(&block)
        return unless $stdin.tty?
        begin
          yield
        rescue
          # fails on windows
        end
      end
    end
  end
end
