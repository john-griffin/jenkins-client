module Jenkins
  class Client
    class Command
      class Base < Clamp::Command
      
        def client
          @client ||= Jenkins::Client.new.tap do |client|
            client.url = @url
            client.username = @username
            client.password = @password
          end
        end
        
      end
    end
  end
end

