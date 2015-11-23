module Bankster
  module BankCredentials
    class Hbci < Base
      def_delegators :@credentials, :url, :url=
      def_delegators :@credentials, :bank_code, :bank_code=
      def_delegators :@credentials, :user_id, :user_id=
      def_delegators :@credentials, :pin, :pin=

      def keys
        [:url, :bank_code, :user_id, :pin]
      end
    end
  end
end
