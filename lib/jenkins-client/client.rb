module Jenkins
  class Client
    attr_accessor :username, :password, :url

    def configure
      yield self
    end

    def connection
      @connection ||= begin
        c = Faraday.new(:url => url) do |builder|
          builder.use FaradayMiddleware::Rashify
          builder.use FaradayMiddleware::ParseJson
          builder.adapter :net_http
        end
        c.basic_auth username, password
        c
      end
    end
    
    def raw_connection
      @raw_connection ||= begin
        c = Faraday.new(:url => url) do |builder|
          builder.adapter :net_http
        end
        c.basic_auth username, password
        c
      end
    end

    def get(path, use_connection = connection)
      normalized_path = normalize_path path
      use_connection.get(normalized_path)
    end

    def post(path, body, use_connection = connection)
      normalized_path = normalize_path path
      resp = use_connection.post do |req|
        req.headers['Content-Type'] = 'application/xml'
        req.url normalized_path
        req.body = body
      end
      resp.status == 200
    end
    
    def jobs
      Hash[get("/api/json").body.jobs.map do |data|
        job = Jenkins::Client::Job.new(data)
        job.client = self
        [ job.name, job ]
      end]
    end

    private
    
    def normalize_path path
      return @connection.path_prefix+path unless @connection.path_prefix == '/'
      path
    end

  end
end