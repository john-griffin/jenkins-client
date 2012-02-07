require "faraday"
require "faraday_middleware"
require 'rash'

module Jenkins
  class Client
    def jobs
      conn = Faraday.new(:url => 'https://testuser:testpass@jenkins.dsci.it') do |builder|
        builder.use FaradayMiddleware::Rashify
        builder.use FaradayMiddleware::ParseJson
        builder.adapter  :net_http
      end
      resp = conn.get "/api/json"
      resp.body.jobs
    end
  end
end