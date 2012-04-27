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

      @connection
      def setup_connection
        @connection = Faraday.new(:url => url) do |builder|
          builder.use FaradayMiddleware::Rashify
          builder.use FaradayMiddleware::ParseJson
          builder.adapter  :net_http
        end
        @connection.basic_auth username, password
      end

      def get(path)
        normalized_path = normalize_path path
        connection.get(normalized_path)
      end

      def post(path, body)
        normalized_path = normalize_path path
        resp = @connection.post do |req|
          req.headers['Content-Type'] = 'application/xml'
          req.url normalized_path
          req.body = body
        end
        resp.status == 200
      end

      private
      def normalize_path path
        return @connection.path_prefix+path unless @connection.path_prefix == '/'
        path
      end
    end

  end
end