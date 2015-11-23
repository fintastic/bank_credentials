require 'spec_helper'

describe Bankster::BankCredentials::Hbci do

  let(:credential_hash) do
    {
      url: "url",
      bank_code: "bank_code",
      user_id: "user_id",
      pin: "pin"
    }
  end

  describe '.from_encoded_json' do
    context 'given valid credentials' do
      let(:encoded_json) { Base64.encode64(credential_hash.to_json) }

      it 'returns a HbciCredentials instance' do
        expect(described_class.from_encoded_json(encoded_json)).to be_a(described_class)
      end

      it 'initializes the HbciCredentials with the credential hash' do
        expect(described_class).to receive(:new).with(credential_hash)

        described_class.from_encoded_json(encoded_json)
      end
    end

    context 'given nil' do
      let(:encoded_json) { nil }

      it 'raises an error' do
        expect{described_class.from_encoded_json(encoded_json)}.
          to raise_error(Bankster::BankCredentials::Errors::Empty)
      end
    end

    context 'given an empty string' do
      let(:encoded_json) { "" }

      it 'raises an error' do
        expect{described_class.from_encoded_json(encoded_json)}.
          to raise_error(Bankster::BankCredentials::Errors::Empty)
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
        expect{ subject.validate! }.to raise_error(Bankster::BankCredentials::Errors::Invalid)
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
