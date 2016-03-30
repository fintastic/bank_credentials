require 'spec_helper'

describe Bankster::BankCredentials::Ebics do
  let(:credential_hash) { valid_ebics_credentials_without_type }

  describe 'attribute readers' do
    subject { described_class.new(credential_hash) }

    it 'provides public access to the credentials' do
      expect(subject.type).to eql("ebics")
      expect(subject.key).to eql("key")
      expect(subject.passphrase).to eql("passphrase")
      expect(subject.host_id).to eql("host_id")
      expect(subject.user_id).to eql("user_id")
      expect(subject.partner_id).to eql("partner_id")
      expect(subject.url).to eql("url")
    end
  end

  describe '#valid?' do
    it 'returns false when one of the keys is missing' do
      [:key, :passphrase, :user_id, :host_id, :partner_id, :url].each do |key|
        expect(described_class.new(credential_hash.merge!({key => nil}))).to_not be_valid
      end
    end

    it 'returns true when none of the keys is missing' do
      expect(described_class.new(credential_hash)).to be_valid
    end
  end

  describe 'validate!' do
    it 'raises an error when one of the keys is missing' do
      [:key, :passphrase, :user_id, :host_id, :partner_id, :url].each do |key|
        subject = described_class.new(credential_hash.merge!({key => nil}), validate: false)
        expect{ subject.validate! }.to raise_error(Bankster::BankCredentials::Ebics::Errors::Invalid)
      end
    end
  end

  describe '#to_h' do
    subject { described_class.new(credential_hash).to_h }

    context 'when credential hash includes the type' do
      let(:credential_hash) { valid_ebics_credentials_with_type }

      it { is_expected.to eql(credential_hash) }
    end

    context 'when credential hash excludes the type' do
      let(:credential_hash) { valid_ebics_credentials_without_type }

      it { is_expected.to eql(valid_ebics_credentials_with_type) }
    end
  end

  describe '#to_json' do
    subject { described_class.new(credential_hash).to_json }

    context 'when credential hash includes the type' do
      let(:credential_hash) { valid_ebics_credentials_with_type }

      it { is_expected.to eql(credential_hash.to_json) }
    end

    context 'when credential hash excludes the type' do
      let(:credential_hash) { valid_ebics_credentials_without_type }

      it { is_expected.to eql(valid_ebics_credentials_with_type.to_json) }
    end
  end

  describe described_class::Errors do
    describe described_class::Empty do
      describe '#to_s' do
        it 'responds correct' do
          expect(subject.to_s).to eql('Empty Ebics credentials')
        end
      end
    end

    describe described_class::Invalid do
      describe '#to_s' do
        it 'responds correct' do
          expect(subject.to_s).to eql('Invalid Ebics credentials')
        end
      end
    end
  end
end
