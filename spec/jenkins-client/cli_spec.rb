require "spec_helper"

describe Jenkins::Client::CLI do
  include OutputCapture
  
  it "prints help by default" do
    Jenkins::Client::CLI.run("jenkins", [])
    stdout.should include "jenkins [OPTIONS] SUBCOMMAND [ARGS]"
    stdout.should include "-u, --username USERNAME"
    stdout.should include "-p, --password PASSWORD"
    stdout.should include "-j, --json"
  end
  
end
