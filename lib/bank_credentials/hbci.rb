# frozen_string_literal: true

require 'open-uri'
require 'json'

module BankCredentials
  class Hbci < Base
    module Errors
      class Invalid < StandardError
        def to_s
          'Invalid Hbci credentials'
        end
      end

      class Empty < StandardError
        def to_s
          'Empty Hbci credentials'
        end
      end

      class Config < StandardError
      end
    end

    BANK_LIST = File.join(File.dirname(__FILE__), '../bank_list.json')

    attribute :url
    attribute :bank_code
    attribute :user_id
    attribute :pin

    def initialize(credential_hash, options = {})
      super
      @bank_list = nil
      @credentials[:url] = bank['pinTanURL'] unless @credentials[:url]
    end

    def bank
      bank = bank_list.find { |b| b['blz'] == bank_code }
      raise Errors::Config, "Bank \"#{bank_code}\" not found in bank list" unless bank
      bank
    end

    private

    def bank_list
      File.open(BANK_LIST, 'r') { |f| @bank_list = JSON.parse(f.read) } unless @bank_list
      raise Errors::Config, 'Bank list is empty' if @bank_list.empty?
      @bank_list
    rescue OpenURI::HTTPError
      raise Errors::Config, 'Bank list not loadable'
    end
  end
end
