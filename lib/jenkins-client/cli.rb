require "clamp"
require "jenkins-client/command/jobs"

module Jenkins
  class Client
    class CLI < Clamp::Command
      subcommand "jobs", "List Jenkins jobs.", Jenkins::Client::Command::Jobs
    end
  end
end

