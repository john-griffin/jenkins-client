# heavily based on the Heroku client gem

require "jenkins-client"
require "jenkins-client/command"

module Jenkins
  class Client
    class CLI
      def self.start(*args)
        command = args.shift.strip rescue "help"
        Jenkins::Client::Command.load
        Jenkins::Client::Command.run(command, args)
      end
    end
  end
end

