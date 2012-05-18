require "spec_helper"

describe Jenkins::Client do
  
  before :each do
    jenkins_config "https://jenkinstest.com"
  end

  let(:client) { @client }
  
  before :each do
    stub_request(:get, "https://testuser:testpass@jenkinstest.com/api/json").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => resp_json(:jenkinstest), :headers => {})
  end

  before :each do
    stub_request(:get, "https://testuser:testpass@emptyjenkinstest.com/api/json").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => resp_json(:emptyjenkinstest), :headers => {})
  end

  describe ".jobs" do
    context "given some jobs are available" do
      let(:jobs) { client.jobs }

      it "will return a list of jobs" do
        jobs.should have(5).items
      end

      it "will contain an expected job" do
        jobs.should include \
          "foo-bar" => {
            "client" => client,
            "name"=>"foo-bar",
            "url"=>"https://testjenkins.com/job/foo-bar/",
            "color"=>"blue"
          }
      end
    end

    context "given no jobs" do
      before :each do
        empty_jenkins_config
      end

      it "will have no jobs" do
        client.jobs.should be_empty
      end
    end
  end

end