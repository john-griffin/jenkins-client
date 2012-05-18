# heavily based on the Heroku client gem

module Jenkins
  class Client
    module Helpers
    
      def display(msg)
        STDOUT.puts(msg)
      end
      
      def error(msg)
        STDERR.puts(msg)
        exit 1
      end

      def longest(items)
        items.map { |i| i.to_s.length }.sort.last
      end
      
    end
  end
end
