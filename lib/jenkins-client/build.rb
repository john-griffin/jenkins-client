module Jenkins
  class Client
    class Build < Base
      def console_text
        job.client.get("#{url}consoleText", { :json => false }).body
      end
    end
  end
end
