module Jenkins
  class Client
    class Job < Hashie::Rash
      attr_accessor :client
      
      def create!(config)
        client.post("/createItem/api/xml?name=#{CGI.escape(name)}", config)
      end
      
      def delete!
        client.post("/job/#{name}/doDelete", "")
      end
  
      def start!
        client.post("/job/#{name}/build", "")
      end
  
      def last_build(status = "")
        build = Jenkins::Client::Build.new(client.get("/job/#{name}/last#{status.capitalize}Build/api/json").body)
        build.job = self
        build
      end
      
      def last_failed_build
        last_build(:failed)
      end
  
      def last_successful_build
        last_build(:successful)
      end
    
    end
  end
end