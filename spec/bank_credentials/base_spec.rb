# frozen_string_literal: true
require 'spec_helper'

describe BankCredentials::Base do
  describe '.attribute' do
    let(:klass) { Class.new(described_class) }

    it 'adds the attribute to the attributes' do
      expect { klass.attribute(:test) }
        .to change { klass.attributes }
        .from([]).to([:test])
    end

    it 'adds the reader delegator' do
      klass.attribute(:test)
      credentials_instance = klass.new(test: 'test')
      expect(credentials_instance.credentials).to receive(:test).once

      credentials_instance.test
    end

    it 'adds the writer delegator' do
      klass.attribute(:test)
      credentials_instance = klass.new(test: 'test')
      expect(credentials_instance.credentials).to receive(:test=).once

      credentials_instance.test = 'asd'
    end
  end

  describe '.attributes' do
    let(:klass) { Class.new(described_class) }
    subject { klass.attributes }

    context 'when there are no attributes' do
      it 'returns an empty array' do
        expect(subject).to eql([])
      end
    end

    it 'returns the attributes' do
      klass.attribute(:test)
      expect(subject).to eql([:test])
    end
  end
end
