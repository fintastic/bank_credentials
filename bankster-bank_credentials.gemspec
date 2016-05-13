# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bankster/bank_credentials/version'

Gem::Specification.new do |spec|
  spec.name          = "bankster-bank_credentials"
  spec.version       = Bankster::BankCredentials::VERSION
  spec.authors       = ["Roman Lehnert"]
  spec.email         = ["roman.lehnert@googlemail.com"]

  spec.summary       = %q{A tiny ruby container for ebics and hbci credentials.}
  spec.description   = %q{Encapsulates and validates the completeness of banking credentials for ebics and hbci.}
  spec.homepage      = "https://github.com/bankster/bankster-bank_credentials"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'rspec', '~> 3'
  spec.add_development_dependency "byebug", '~> 5'
end
