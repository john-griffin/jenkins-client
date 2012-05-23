module Jenkins
  class Client
    class Command
      class Jobs < Base
        def execute
          display client.jobs.map { |job_name, job|
            @json ? job.to_json : job_name
          }
        end
      end
    end
  end
end

