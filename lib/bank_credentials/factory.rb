# frozen_string_literal: true
module BankCredentials
  class Factory
    def self.from_hash(credentials)
      raise Errors::Invalid unless credentials.is_a?(Hash)
      raise Errors::Invalid unless credentials.key?(:type)

      class_for_type(credentials[:type]).new(credentials)
    end

    def self.from_encoded_json(encoded_json)
      raise Errors::Invalid if encoded_json.nil?
      raise Errors::Invalid if encoded_json.empty?
      raise Errors::Invalid unless encoded_json.is_a?(String)

      credentials = JSON.parse(Base64.urlsafe_decode64(encoded_json), symbolize_names: true)

      class_for_type(credentials[:type]).new(credentials)

    rescue JSON::ParserError, ArgumentError
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
