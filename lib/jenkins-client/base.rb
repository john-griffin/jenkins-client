module Jenkins
  class Client
    class Base < Hashie::Rash
      def to_json(*args)
        to_hash.tap { |h| h.delete("client") }.to_json(*args)
      end
    end
  end
end
