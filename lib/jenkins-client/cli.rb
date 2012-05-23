require "clamp"
require "jenkins-client"
require "jenkins-client/command/base"
require "jenkins-client/command/jobs"

module Jenkins
  class Client
    class CLI < Clamp::Command
      option "--url", "URL", "Jenkins instance url.", :default => "localhost:8080"
      option ["-u", "--username"], "USERNAME", "Jenkins username."
      option ["-p", "--password"], "PASSWORD", "Jenkins password."
      option ["-j", "--json"], :flag, "Output JSON instead of plain text."
      subcommand "jobs", "List Jenkins jobs.", Jenkins::Client::Command::Jobs
    end
  end
end

