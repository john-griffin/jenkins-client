require "spec_helper"
require "jenkins-client"
require "jenkins-client/job"

describe Jenkins::Client::Job do 
  before(:each) do
    Jenkins::Client.configure do |c|
      c.username = "testuser"
      c.password = "testpass"
      c.url = "https://jenkinstest.com"
    end
  end

  describe ".all" do
    it "will return a list of jobs" do
      body = '{"assignedLabels":[{}],"mode":"NORMAL","nodeDescription":"the master Jenkins node","nodeName":"","numExecutors":2,"description":null,"jobs":[
      {"name":"foo-bar","url":"https://testjenkins.com/job/foo-bar/","color":"blue"},
      {"name":"woohoo","url":"https://jenkinstest.com/job/woohoo/","color":"red"},
      {"name":"wat","url":"https://jenkinstest.com/job/wat/","color":"red"},
      {"name":"fudge","url":"https://jenkinstest.com/job/fudge/","color":"blue"},
      {"name":"amaze","url":"https://jenkinstest.com/job/amaze/","color":"blue"}]}'
      stub_request(:get, "https://testuser:testpass@jenkinstest.com/api/json").
         with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
         to_return(:status => 200, :body => body, :headers => {})
      Jenkins::Client::Job.all.should include({"name"=>"foo-bar",
        "url"=>"https://testjenkins.com/job/foo-bar/",
        "color"=>"blue"})
      Jenkins::Client::Job.all.should have(5).items
    end
  end
end