require 'spec_helper'

describe Bankster::BankCredentials::Factory do

  describe '.from_hash' do
    subject { described_class.from_hash(credentials) }
    context 'given a valid hbci credential hash' do
      let(:credentials) { valid_hbci_credentials_with_type }

      it { is_expected.to be_a(Bankster::BankCredentials::Hbci) }
    end

    context 'given a valid hbci credential hash without type' do
      let(:credentials) { valid_hbci_credentials_without_type }

      specify { expect { subject }.to raise_error(Bankster::BankCredentials::Errors::Invalid) }
    end

    context 'given a valid ebics credential hash without type' do
      let(:credentials) { valid_ebics_credentials_without_type }

      specify { expect { subject }.to raise_error(Bankster::BankCredentials::Errors::Invalid) }
    end

    context 'given a valid hbci credential hash' do
      let(:credentials) { valid_ebics_credentials_with_type }

      it { is_expected.to be_a(Bankster::BankCredentials::Ebics) }
    end

    context 'given an empty hash' do
      let(:credentials) { {} }

      specify { expect { subject }.to raise_error(Bankster::BankCredentials::Errors::Invalid) }
    end

    context 'given nil' do
      let(:credentials) { nil }

      specify { expect { subject }.to raise_error(Bankster::BankCredentials::Errors::Invalid) }
    end
  end

  describe '.from_encoded_json' do
    let(:encoded_json) { Base64.encode64(credential_hash.to_json) }

    context 'given a valid ebics credential hash' do
      let(:credential_hash) { valid_ebics_credentials }

      it 'returns an ebics credential object' do
        expect(described_class.from_encoded_json(encoded_json)).to be_a(Bankster::BankCredentials::Ebics)
      end

      it 'initializes the credential object with the credential hash' do
        expect(Bankster::BankCredentials::Ebics).to receive(:new).with(credential_hash)

        described_class.from_encoded_json(encoded_json)
      end
    end

    context 'given a hbci credential hash' do
      let(:credential_hash) { valid_hbci_credentials }

      it 'returns an hbci credential object' do
        expect(described_class.from_encoded_json(encoded_json)).to be_a(Bankster::BankCredentials::Hbci)
      end

      it 'initializes the credential object with the credential hash' do
        expect(Bankster::BankCredentials::Hbci).to receive(:new).with(credential_hash)

        described_class.from_encoded_json(encoded_json)
      end
    end

    context 'given nil' do
      let(:encoded_json) { nil }

      it 'raises an error' do
        expect{described_class.from_encoded_json(encoded_json)}.
          to raise_error(Bankster::BankCredentials::Errors::Invalid)
      end
    end

    context 'given an empty string' do
      let(:encoded_json) { "" }

      it 'raises an error' do
        expect{described_class.from_encoded_json(encoded_json)}.
          to raise_error(Bankster::BankCredentials::Errors::Invalid)
      end
    end

    context 'given unparseable json' do
      let(:encoded_json) { "asd" }

      it 'raises an error' do
        expect{described_class.from_encoded_json(encoded_json)}.
          to raise_error(Bankster::BankCredentials::Errors::Invalid)
      end
    end

    context 'given a hash' do
      let(:encoded_json) { {a: "asd"}  }

      it 'raises an error' do
        expect{described_class.from_encoded_json(encoded_json)}.
          to raise_error(Bankster::BankCredentials::Errors::Invalid)
      end
    end
  end
end
