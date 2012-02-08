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

  before(:each) do
    body = '{"assignedLabels":[{}],"mode":"NORMAL","nodeDescription":"the master Jenkins node","nodeName":"","numExecutors":2,"description":null,"jobs":[
    {"name":"foo-bar","url":"https://testjenkins.com/job/foo-bar/","color":"blue"},
    {"name":"woohoo","url":"https://jenkinstest.com/job/woohoo/","color":"red"},
    {"name":"wat","url":"https://jenkinstest.com/job/wat/","color":"red"},
    {"name":"fudge","url":"https://jenkinstest.com/job/fudge/","color":"blue"},
    {"name":"amaze","url":"https://jenkinstest.com/job/amaze/","color":"blue"}]}'
    stub_request(:get, "https://testuser:testpass@jenkinstest.com/api/json").
       with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
       to_return(:status => 200, :body => body, :headers => {})        
  end

  describe ".all" do
    context "given some jobs are available" do
      let(:jobs){Jenkins::Client::Job.all}

      it "will return a list of jobs" do
        jobs.should have(5).items
      end

      it "will contain an expected job" do
        jobs.should include({
          "name"=>"foo-bar", 
          "url"=>"https://testjenkins.com/job/foo-bar/",
          "color"=>"blue"
        })
      end
    end
  end

  describe ".find" do
    context "given some jobs are available" do
      it "will find the specified job" do
        job = Jenkins::Client::Job.find("woohoo")
        job.url.should eq("https://jenkinstest.com/job/woohoo/")
      end
    end
  end
end