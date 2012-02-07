module Jenkins
  class Client
    class Job
      def jobs
        resp = Jenkins::Client.get "/api/json"
        resp.body.jobs
      end
    end
  end
end