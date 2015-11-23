require 'base64'
require 'json'

module Bankster
  module BankCredentials

    class Base
      extend Forwardable

      attr_reader :credentials

      def self.from_encoded_json(encoded_json)
        raise Errors::Empty if encoded_json.nil? || encoded_json.empty? 
        raise Errors::Invalid if !encoded_json.is_a?(String)

        self.new(JSON.parse(Base64.decode64(encoded_json), symbolize_names: true))

      rescue JSON::ParserError
        raise Errors::Invalid
      end

      def initialize(credential_hash, options = {})
        @credentials = OpenStruct.new(credential_hash)
        validate! unless !options[:validate]
      end

      def to_h
        @credentials.to_h
      end

      def to_json
        to_h.to_json
      end

      def valid?
        keys.each do |key|
          return false if @credentials[key].nil? || @credentials[key].empty?
        end
      end

      def validate!
        raise Errors::Invalid unless valid?
      end
    end
  end
end
