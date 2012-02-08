module Jenkins
  class Client
    class Job
      def self.all
        resp = Jenkins::Client.get "/api/json"
        resp.body.jobs
      end

      def self.find(name)
        all.select{|j| j.name == name}.first
      end

      def self.create(name, config)
        Jenkins::Client.post("/createItem/api/xml?name=#{CGI.escape(name)}", config)
      end
    end
  end
end