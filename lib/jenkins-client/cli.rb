require "clamp"
require "jenkins-client"
require "jenkins-client/command/base"
require "jenkins-client/command/jobs"

module Jenkins
  class Client
    class CLI < Clamp::Command
      option "--url", "URL", "jenkins url", :default => "localhost:8080"
      option ["-u", "--username"], "USERNAME", "jenkins username"
      option ["-p", "--password"], "PASSWORD", "jenkins password"
      option ["-j", "--json"], :flag, "output JSON"
      subcommand "jobs", "List Jenkins jobs.", Jenkins::Client::Command::Jobs
    end
  end
end

