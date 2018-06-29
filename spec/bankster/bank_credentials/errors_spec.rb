# frozen_string_literal: true
require 'spec_helper'

describe BankCredentials::Errors::Base do
  it 'has a message when given a message' do
    expect do
      raise described_class, 'oh no!'
    end.to raise_error { |error|
      expect(error.message).to eql('oh no!')
      expect(error.to_s).to eql('oh no!')
    }
  end
end
