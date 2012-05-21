module Jenkins
  class Client
    class Command
      class Jobs < Base
        def execute
          client.jobs.each_pair do |job_name, job|
            if @json
              puts job.to_json
            else
              puts job_name
            end
          end
        end
      end
    end
  end
end

