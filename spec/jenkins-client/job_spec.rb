require "spec_helper"

describe Jenkins::Client::Job do

  before(:each) do
    jenkins_config("https://jenkinstest.com")
  end
  
  describe ".create!" do
    before(:each) do
      stub_request(:post, "https://testuser:testpass@jenkinstest.com/createItem/api/xml?name=excellent").
          to_return(:status => 200, :body => "", :headers => {})
    end

    context "given an xml config file" do
      it "will be able to create a new jenkins job" do
        config = File.open("spec/fixtures/jenkins_config.xml").read
        job = Jenkins::Client::Job.new({ name: "excellent" })
        job.client = @client
        job.create!(config).should be_true
      end
    end

    context "jenkins is not root app" do
      before(:each) do
        jenkins_config("https://jenkinstest.com/jenkins")
        stub_request(:post, "https://testuser:testpass@jenkinstest.com/jenkins/createItem/api/xml?name=excellent").
            to_return(:status => 200, :body => "", :headers => {})
      end

      it "should be able to create a new job" do
        config = File.read("spec/fixtures/jenkins_config.xml")
        job = Jenkins::Client::Job.new({ name: "excellent" })
        job.client = @client
        job.create!(config).should be_true
      end
    end
  end

  describe ".delete!" do
    context "there is a job to delete" do
      before(:each) do
        stub_request(:post, "https://testuser:testpass@jenkinstest.com/createItem/api/xml?name=excellent").
            to_return(:status => 200, :body => "", :headers => {})

        stub_request(:post, "https://testuser:testpass@jenkinstest.com/job/excellent/doDelete").
            with(:headers => {'Accept'=>'*/*', 'Content-Type'=>'application/xml', 'User-Agent'=>'Ruby'}).
            to_return(:status => 200, :body => "", :headers => {})
      end

      it "should delete the job" do
        job = Jenkins::Client::Job.new({ name: "excellent" })
        job.client = @client
        job.delete!.should be_true
      end
    end
  end

  describe ".start!" do
    context "there is a job to start" do
       before(:each) do
         stub_request(:post, "https://testuser.testpass@jenkinstest.com/createItem/api/xml?name=excellent").
             to_return(:status => 200, :body => "", :headers => {})
         stub_request(:post, "https://testuser:testpass@jenkinstest.com/job/excellent/build").
             with(:headers => {'Accept'=>'*/*', 'Content-Type'=>'application/xml', 'User-Agent'=>'Ruby'}).
             to_return(:status => 200, :body => "", :headers => {})
       end

      it "should start the build for this job" do
        job = Jenkins::Client::Job.new({ name: "excellent" })
        job.client = @client
        job.start!
      end

    end
  end

  describe ".last_build" do
    context "a build has been started" do
     before(:each) do
       stub_request(:post, "https://testuser.testpass@jenkinstest.com/createItem/api/xml?name=excellent").
           to_return(:status => 200, :body => "", :headers => {})
       stub_request(:post, "https://testuser:testpass@jenkinstest.com/job/excellent/build").
           to_return(:status => 200, :body => "", :headers => {})
       stub_request(:get, "https://testuser:testpass@jenkinstest.com/job/excellent/lastBuild/api/json").
           with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
           to_return(:status => 200, :body => resp_lastbuild, :headers => {})
     end

      it "should return 1 as buildNumber" do
        job = Jenkins::Client::Job.new({ name: "excellent" })
        job.client = @client
        job.last_build.number.should == 1
      end
      
    end
  end
  
  pending ".last_successful_build"
  pending ".last_failed_build"

  def resp_lastbuild
    current_dir = File.expand_path(File.dirname((__FILE__)))
    IO.read(File.join(current_dir, "..", "support", "resp_last_build.json"))
  end
  
end