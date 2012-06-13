module Jenkins
  class Client
    class Command
      class Base < Clamp::Command

        class << self
          def client=(value)
            @client = value
          end
          def client
            @client
          end
        end
      
        def client
          @client ||= Jenkins::Client::Command::Base.client
          @client ||= Jenkins::Client.new.tap do |client|
            client.url = @url
            client.username = @username
            client.password = @password
          end
        end
        
        def display(msg)
          if @json
            puts msg.to_json
          elsif msg.respond_to?(:each)
            msg.each { |m| display(m) }
          else
            puts msg.to_s
          end
        end
        
      end
    end
  end
end

