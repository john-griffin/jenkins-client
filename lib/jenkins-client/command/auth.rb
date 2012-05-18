require "jenkins-client/command/base"
require "jenkins-client/auth"

# authentication (login, logout)
module Jenkins
  class Client
    class Command
      class Auth < Jenkins::Client::Command::Base

        # auth:login
        #
        # log in with your jenkins credentials
        #
        def login
          Jenkins::Client::Auth.login
          display "Authentication successful."
        end

        alias_command "login", "auth:login"

        # auth:logout
        #
        # clear local authentication credentials
        #
        def logout
          Jenkins::Client::Auth.logout
          display "Local credentials cleared."
        end

        alias_command "logout", "auth:logout"

      end
    end
  end
end

