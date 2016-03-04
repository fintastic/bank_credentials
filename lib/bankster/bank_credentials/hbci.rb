module Bankster
  module BankCredentials
    class Hbci < Base
      module Errors
        class Invalid < StandardError
          def to_s
            'Invalid HBCI credentials'
          end
        end

        class Empty < StandardError
          def to_s
            'Empty HBCI Credentials'
          end
        end
      end

      attribute :url
      attribute :bank_code
      attribute :user_id
      attribute :pin
    end
  end
end
