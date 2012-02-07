require "faraday"
require "faraday_middleware"
require 'rash'

module Jenkins
  class Client
    attr_accessor :username, :password, :url

    def connection
      conn = Faraday.new(:url => url) do |builder|
        builder.use FaradayMiddleware::Rashify
        builder.use FaradayMiddleware::ParseJson
        builder.adapter  :net_http
      end
      conn.basic_auth username, password
      conn      
    end

    def jobs
      resp = connection.get "/api/json"
      resp.body.jobs
    end
  end
end