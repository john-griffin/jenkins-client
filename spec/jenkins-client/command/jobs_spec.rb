require "spec_helper"

describe Jenkins::Client::CLI do
  include OutputCapture
  
  before :each do
    jenkins_config "https://jenkinstest.com"
    Jenkins::Client::Command::Base.client = @client
  end

  before :each do
    stub_request(:get, "https://testuser:testpass@jenkinstest.com/api/json").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => resp_json(:jenkinstest), :headers => {})
  end
  
  it "lists jobs" do
    Jenkins::Client::CLI.run("jenkins", [ "jobs" ])
    stdout.strip.should == [ "foo-bar", "woohoo", "wat", "fudge", "amaze" ].join("\n")
  end

  it "lists jobs in json format" do
    Jenkins::Client::CLI.run("jenkins", [ "--json", "jobs" ])
    json = JSON.parse(stdout)
    json.length.should == 5
    json.should include({
      "name" => "foo-bar",
      "url" => "https://testjenkins.com/job/foo-bar/",
      "color" => "blue"
    }.to_json)
  end
  
end
