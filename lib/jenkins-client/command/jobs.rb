module Jenkins
  class Client
    class Command
      class Jobs < Clamp::Command
        def execute
          puts "executing jobs ..."
        end
      end
    end
  end
end

