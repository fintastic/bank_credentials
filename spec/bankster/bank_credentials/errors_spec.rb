require 'spec_helper'

describe Bankster::BankCredentials::Errors::Base do
  it 'has a message when given a message' do
    expect {
      raise described_class, "oh no!"
    }.to raise_error { |error|
      expect(error.message).to eql("oh no!")
      expect(error.to_s).to eql("oh no!")
    }
  end
end
