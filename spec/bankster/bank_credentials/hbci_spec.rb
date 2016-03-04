require 'spec_helper'

describe Bankster::BankCredentials::Hbci do

  let(:credential_hash) { valid_hbci_credentials }

  describe 'attribute readers' do
    subject { described_class.new(credential_hash) }

    it 'provides public access to the credentials' do
      expect(subject.url).to eql("url")
      expect(subject.bank_code).to eql("bank_code")
      expect(subject.user_id).to eql("user_id")
      expect(subject.pin).to eql("pin")
    end
  end

  describe '#valid?' do
    it 'returns false when one of the keys is missing' do
      [:url, :bank_code, :user_id, :pin].each do |key|
        expect(described_class.new(credential_hash.merge!({key => nil}))).to_not be_valid
      end
    end

    it 'returns true when none of the keys is missing' do
      expect(described_class.new(credential_hash)).to be_valid
    end
  end

  describe 'validate!' do
    it 'raises an error when one of the keys is missing' do
      [:url, :bank_code, :user_id, :pin].each do |key|
        subject = described_class.new(credential_hash.merge!({key => nil}), validate: false)
        expect{ subject.validate! }.to raise_error(Bankster::BankCredentials::Hbci::Errors::Invalid)
      end
    end
  end

  describe '#to_h' do
    it 'returns a credentials hash' do
      subject = described_class.new(credential_hash)
      expect(subject.to_h).to eql(credential_hash)
    end
  end

  describe '#to_json' do
    it 'returns a jsonified credentials hash' do
      subject = described_class.new(credential_hash)
      expect(subject.to_json).to eql(credential_hash.to_json)
    end
  end
end
