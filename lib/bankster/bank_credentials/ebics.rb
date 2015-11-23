module Bankster
  module BankCredentials
    class Ebics < Base
      def_delegators :@credentials, :key, :key=
      def_delegators :@credentials, :passphrase, :passphrase=
      def_delegators :@credentials, :url, :url=
      def_delegators :@credentials, :host_id, :host_id=
      def_delegators :@credentials, :partner_id, :partner_id=
      def_delegators :@credentials, :user_id, :user_id=

      def keys
        [:key, :passphrase, :user_id, :host_id, :partner_id, :url]
      end
    end
  end
end
