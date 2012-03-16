require "jenkins-client/client"

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

      def self.delete(name)
        Jenkins::Client.post("/job/#{name}/doDelete", "")
      end

      def self.start(name)
        Jenkins::Client.post("#{name}/build", "")
      end
    end
  end
end