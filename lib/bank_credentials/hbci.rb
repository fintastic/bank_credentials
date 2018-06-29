# frozen_string_literal: true

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
    end

    attribute :url
    attribute :bank_code
    attribute :user_id
    attribute :pin
  end
end
