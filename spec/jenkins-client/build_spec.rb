require "spec_helper"

describe Jenkins::Client::Build do
  
  before :each do
    jenkins_config "https://jenkinstest.com"
  end
  
  let(:client) { @client }
  let(:job) { Jenkins::Client::Job.new({ :name => "test_job", :client => @client }) }
  
  describe ".console_text" do
    before :each do
      stub_request(:get, "https://testuser:testpass@jenkinstest.com/job/test_job/lastBuild/consoleText").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => "console\ntext", :headers => {})
    end
    let(:build) { Jenkins::Client::Build.new({ :url => "#{client.url}/job/#{job.name}/lastBuild/", :job => job }) }

    it "returns console text" do
      build.console_text.should == "console\ntext"
    end
  end
  
  
end