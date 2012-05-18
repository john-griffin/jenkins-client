require "jenkins-client"
require "jenkins-client/helpers"
require "jenkins-client/netrc"

module Jenkins
  class Client
    class Auth
      class << self
        include Jenkins::Client::Helpers

        attr_accessor :credentials

        def client
          @client ||= Jenkins::Client.new({ :username => username, :password => password, :url => url })
        end

        def login
          delete_credentials
          get_credentials
        end

        def logout
          delete_credentials
        end

        # just a stub; will raise if not authenticated
        def check
          client.list
        end

        def default_url
          "http://localhost:8080"
        end

        def url
          ENV['JENKINS_URL'] || default_url
        end

        def reauthorize
          @credentials = ask_for_and_save_credentials
        end

        def username # :nodoc:
          get_credentials[0]
        end

        def password # :nodoc:
          get_credentials[1]
        end

        def get_credentials # :nodoc:
          @credentials ||= (read_credentials || ask_for_and_save_credentials)
        end

        def delete_credentials
          if netrc
            netrc.delete("client.#{url}")
            netrc.save
          end
          @client, @credentials = nil, nil
        end

        def netrc_path
          if running_on_windows?
            "#{home_directory}/_netrc"
          else
            "#{home_directory}/.netrc"
          end
        end

        def netrc   # :nodoc:
          @netrc ||= begin
            File.exists?(netrc_path) && Jenkins::Client::Netrc.read(netrc_path)
          rescue => error
            if error.message =~ /^Permission bits for/
              perm = File.stat(netrc_path).mode & 0777
              abort("Permissions #{perm} for '#{netrc_path}' are too open. You should run `chmod 0600 #{netrc_path}` so that your credentials are NOT accessible by others.")
            else
              raise error
            end
          end
        end

        def read_credentials
          # read netrc credentials if they exist
          if netrc
            netrc["client.#{url}"]
          end
        end

        def write_credentials
          FileUtils.mkdir_p(File.dirname(netrc_path))
          FileUtils.touch(netrc_path)
          unless running_on_windows?
            FileUtils.chmod(0600, netrc_path)
          end
          netrc["client.#{url}"] = self.credentials
          netrc.save
        end

        def echo_off
          with_tty do
            system "stty -echo"
          end
        end

        def echo_on
          with_tty do
            system "stty echo"
          end
        end

        def ask_for_credentials
          puts "Enter your Jenkins credentials."

          print "Username: "
          username = ask

          print "Password: "
          password = running_on_windows? ? ask_for_password_on_windows : ask_for_password

          [ username, password ]
        end

        def ask_for_password_on_windows
          require "Win32API"
          char = nil
          password = ''

          while char = Win32API.new("crtdll", "_getch", [ ], "L").Call do
            break if char == 10 || char == 13 # received carriage return or newline
            if char == 127 || char == 8 # backspace and delete
              password.slice!(-1, 1)
            else
              # windows might throw a -1 at us so make sure to handle RangeError
              (password << char.chr) rescue RangeError
            end
          end
          puts
          return password
        end

        def ask_for_password
          echo_off
          trap("INT") do
            echo_on
            puts("\n !    Command cancelled.")
            exit
          end
          password = ask
          puts
          echo_on
          return password
        end

        def ask_for_and_save_credentials
          begin
            @credentials = ask_for_credentials
            write_credentials
          # TODO: check and retry
          rescue Exception => e
            delete_credentials
            raise e
          end
          @credentials
        end

      end
    end
  end
end

