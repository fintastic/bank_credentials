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
            'Invalid ebics credentials'
          end
        end

        class Empty < StandardError
          def to_s
            'Empty Ebics Credentials'
          end
        end
      end
    end
  end
end
