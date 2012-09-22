module Jenkins
  class Client
    attr_accessor :username, :password, :url

    def configure
      yield self
    end
    
    def get(path, options = default_connection_options)
      connection(options).get(normalize_path(path, options))
    end

    def post(path, body, options = default_connection_options)
      resp = connection(options).post do |req|
        req.headers['Content-Type'] = 'application/xml'
        req.url normalize_path(path, options)
        req.body = body
      end
      resp.status == 200
    end
    
    def jobs
      Hash[get("/api/json").body.jobs.map do |data|
        job = Jenkins::Client::Job.new(data.merge({ :client => self }))
        [ job.name, job ]
      end]
    end
    
    private
    
    def default_connection_options
      { :json => true }
    end
    
    def connection(options = default_connection_options)
      @connections ||=  {}
      @connections[options.map { |k, v| "#{k}=#{v}" }.join("|")] ||= begin
        uri = url[/^http?s:\/\//] ? url : "http://#{url}"
        c = Faraday.new(:url => uri) do |builder|
          if options[:json]
            builder.use FaradayMiddleware::Rashify
            builder.use FaradayMiddleware::ParseJson
          end
          builder.adapter :net_http
        end
        c.basic_auth username, password
        c
      end
    end
    
    def normalize_path(path, options = default_connection_options)
      connection(options).path_prefix == '/' ? path : connection.path_prefix + path
    end

  end
end
