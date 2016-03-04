module Bankster
  module BankCredentials
    module Errors
      class Base < StandardError
      end

      class Invalid < Base
        def to_s
          'Invalid credentials'
        end
      end
    end
  end
end

