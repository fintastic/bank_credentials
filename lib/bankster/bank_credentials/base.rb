module Bankster
  module BankCredentials
    class Base
      extend Forwardable
      attr_reader :credentials
      def_delegator :credentials, :to_h

      def self.type
        name.nil? ? 'base' : name.split('::').last.downcase 
      end

      def self.attributes
        @attributes = [] if @attributes.nil?
        @attributes
      end

      def self.attribute(attribute)
        @attributes = [] if @attributes.nil?
        @attributes << attribute
        def_delegator :@credentials, attribute
        def_delegator :@credentials, "#{attribute}=".to_sym
      end


      def initialize(credential_hash, options = {})
        credential_hash[:type] = credential_hash[:type] || self.class.type || nil
        @credentials = OpenStruct.new(credential_hash)
        validate! unless !options[:validate]
      end

      def to_json
        to_h.to_json
      end

      def attributes
        self.class.attributes
      end

      def valid?
        attributes.each do |attribute|
          return false if @credentials[attribute].nil? || @credentials[attribute].empty?
        end
      end

      def validate!
        raise self.class::Errors::Invalid unless valid?
      end

      attribute :type
    end
  end
end
