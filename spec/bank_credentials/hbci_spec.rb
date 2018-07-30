# frozen_string_literal: true

require 'spec_helper'

describe BankCredentials::Hbci do
  let(:credential_hash) { valid_hbci_credentials_without_type }

  describe 'attribute readers' do
    subject { described_class.new(credential_hash) }

    it 'provides public access to the credentials' do
      expect(subject.url).to eql('url')
      expect(subject.bank_code).to eql('bank_code')
      expect(subject.user_id).to eql('user_id')
      expect(subject.pin).to eql('pin')
    end
  end

  describe '#url' do
    let(:credential_hash) do
      {
        bank_code: '10020890',
        user_id: 'user_id',
        pin: 'pin'
      }
    end

    subject { described_class.new(credential_hash) }

    context 'with valid bank list' do
      it 'returns endpoint url' do
        expect(subject.url).to eql('https://hbci-01.hypovereinsbank.de/bank/hbci')
      end
    end
  end

  describe '#valid?' do
    it 'returns false when one of the keys is missing' do
      %i[bank_code user_id pin].each do |key|
        expect(described_class.new(credential_hash.merge!(key => nil))).to_not be_valid
      end
    end

    it 'returns true when none of the keys is missing' do
      expect(described_class.new(credential_hash)).to be_valid
    end
  end

  describe 'validate!' do
    it 'raises an error when one of the keys is missing' do
      %i[bank_code user_id pin].each do |key|
        subject = described_class.new(credential_hash.merge!(key => nil), validate: false)
        expect { subject.validate! }.to raise_error(BankCredentials::Hbci::Errors::Invalid)
      end
    end
  end

  describe '#to_h' do
    subject { described_class.new(credential_hash).to_h }

    context 'when credential hash includes the type' do
      let(:credential_hash) { valid_hbci_credentials_with_type }

      it { is_expected.to eql(credential_hash) }
    end

    context 'when credential hash excludes the type' do
      let(:credential_hash) { valid_hbci_credentials_without_type }

      it { is_expected.to eql(valid_hbci_credentials_with_type) }
    end
  end

  describe '#to_json' do
    subject { described_class.new(credential_hash).to_json }

    context 'when credential hash includes the type' do
      let(:credential_hash) { valid_hbci_credentials_with_type }

      it { is_expected.to eql(credential_hash.to_json) }
    end

    context 'when credential hash excludes the type' do
      let(:credential_hash) { valid_hbci_credentials_without_type }

      it { is_expected.to eql(valid_hbci_credentials_with_type.to_json) }
    end
  end

  describe '#encode' do
    subject { described_class.new(credential_hash).encode }

    it 'returns the ursafe base64 encoded string' do
      expect(subject).to eql(
        Base64.urlsafe_encode64(described_class.new(credential_hash).to_json)
      )
    end
  end

  describe described_class::Errors do
    describe described_class::Empty do
      describe '#to_s' do
        it 'responds correct' do
          expect(subject.to_s).to eql('Empty Hbci credentials')
        end
      end
    end

    describe described_class::Invalid do
      describe '#to_s' do
        it 'responds correct' do
          expect(subject.to_s).to eql('Invalid Hbci credentials')
        end
      end
    end
  end
end
