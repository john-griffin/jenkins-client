module Jenkins
  class Client
    class Build < Hashie::Rash
      attr_accessor :job
      
      def console_text
        job.client.get("#{url}consoleText", job.client.raw_connection).body
      end
    end
  end
end