module Bankster
  module BankCredentials
    module Errors
      class Base < StandardError; end

      class Invalid < Base; end
      class Empty < Base; end
    end
  end
end

