module Bankster
  module BankCredentials
    class Factory
      def self.from_encoded_json(encoded_json)
        raise Errors::Invalid if encoded_json.nil? 
        raise Errors::Invalid if encoded_json.empty? 
        raise Errors::Invalid if !encoded_json.is_a?(String)

        credentials = JSON.parse(Base64.decode64(encoded_json), symbolize_names: true)

        class_for_type(credentials[:type]).new(credentials)

      rescue JSON::ParserError
        raise Errors::Invalid
      end

      def self.class_for_type(type)
        case type
        when 'ebics' then Ebics
        when 'hbci' then Hbci
        end
      end
    end
  end
end
