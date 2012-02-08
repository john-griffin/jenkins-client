require "faraday"
require "faraday_middleware"
require 'rash'

module Jenkins
  class Client
    class << self
      attr_accessor :username, :password, :url, :connection

      def configure
        yield self
        setup_connection
      end

      def setup_connection
        @connection = Faraday.new(:url => url) do |builder|
          builder.use FaradayMiddleware::Rashify
          builder.use FaradayMiddleware::ParseJson
          builder.adapter  :net_http
        end
        @connection.basic_auth username, password
      end

      def get(path)
        connection.get(path)
      end

      def post(path, body)
        resp = @connection.post do |req|
          req.headers['Content-Type'] = 'application/xml'
          req.url path
          req.body = body
        end
        resp.status == 200
      end
    end

    def jobs
      resp = Jenkins::Client.get "/api/json"
      resp.body.jobs
    end
  end
end