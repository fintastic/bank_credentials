# coding: utf-8
# frozen_string_literal: true
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bank_credentials/version'

Gem::Specification.new do |spec|
  spec.name          = 'bank_credentials'
  spec.version       = BankCredentials::VERSION
  spec.authors       = ['Roman Lehnert']
  spec.email         = ['roman.lehnert@gmail.com']

  spec.summary       = 'A tiny ruby container for ebics and hbci credentials.'
  spec.description   = 'Encapsulates and validates the completeness of banking credentials for ebics and hbci.'
  spec.homepage      = 'https://github.com/xxxxxxxxxxxxxbank_credentials'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3'
  spec.add_development_dependency 'byebug', '~> 5'
  spec.add_development_dependency 'rubysl-forwardable'
end