# frozen_string_literal: true
module Bankster
  module BankCredentials
    class Ebics < Base
      attribute :key
      attribute :passphrase
      attribute :user_id
      attribute :host_id
      attribute :partner_id
      attribute :url

      module Errors
        class Invalid < StandardError
          def to_s
            'Invalid Ebics credentials'
          end
        end

        class Empty < StandardError
          def to_s
            'Empty Ebics credentials'
          end
        end
      end
    end
  end
end
