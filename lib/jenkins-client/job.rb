module Jenkins
  class Client
    class Job
      def self.all
        resp = Jenkins::Client.get "/api/json"
        resp.body.jobs
      end
    end
  end
end