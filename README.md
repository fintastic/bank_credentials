# BankCredentials

BankCredentials is a tiny wrapper for keeping together bank credentials for HBCI or Ebics. 

- [Installation](#installation)
- [Usage with Ebics credentials](#ebics-credentials)
- [Usage with Hbci credentials](#hbci-credentials)

[![Build Status](https://travis-ci.org/fintastic/bank_credentials.svg?branch=master)](https://travis-ci.org/fintastic/bank_credentials)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bank_credentials'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bank_credentials

## Usage

### Ebics Credentials

Ebics credentials require the following attributes:

* key
* Host URL of the ebics server
* Host ID
* Partner ID
* Passphrase

#### Feeding with credentials hash
Take a credentials hash and initialize an `BankCredentials::Ebics` instance with it. 
```ruby
credential_hash = {
  key:        "key",
  url:        "url",
  host_id:    "host_id",
  user_id:    "user_id",
  partner_id: "partner_id"
  passphrase: "passphrase",
}

credentials = BankCredentials::Ebics.new(credential_hash)
```
At initialization, the completeness of the attributes will be validated. If they are invalid, `BankCredentials::Error::Invalid` will be raised. 


#### Feeding with a base64 encoded json hash
To create an instance from a base64 encoded json string, use `.from_encoded_json`:
```ruby
credential_hash = {
  key:        "key",
  url:        "url",
  host_id:    "host_id",
  user_id:    "user_id",
  partner_id: "partner_id"
  passphrase: "passphrase",
}

encoded_json = Base64.decode64(credential_hash.to_json)

credentials = BankCredentials::Ebics.from_encoded_json(encoded_json)
```
When the given argument is not valid json, `BankCredentials::Errors::Invalid` will be raised.

Attribute accessors are provided:
```ruby
credentials.key        # => "key"
credentials.host_id    # => "host_id"
credentials.partner_id # => "partner_id"
credentials.user_id    # => "user_id"
credentials.passphrase # => "passphrase"
```


### HBCI Credentials

Ebics credentials require the following attributes:

* Host URL of the HBCI server
* Bank code
* user id
* pin

#### Feeding with credentials hash
Take a credentials hash and initialize an `BankCredentials::Hbci` instance with it. 
```ruby
credential_hash = {
  url:        "url",
  bank_code:  "bank_code",
  user_id:    "user_id",
  pin:        "pin"
}

credentials = BankCredentials::Hbci.new(credential_hash)
```
At initialization, the completeness of the attributes will be validated. If they are invalid, `BankCredentials::Error::Invalid` will be raised. 


#### Feeding with a base64 encoded json hash
To create an instance from a base64 encoded json string, use `.from_encoded_json`:
```ruby
credential_hash = {
  url:        "url",
  user_id:    "user_id",
  bank_code:  "bank_code",
  pin:        "pin"
}

encoded_json = Base64.decode64(credential_hash.to_json)

credentials = BankCredentials::Hbci.from_encoded_json(encoded_json)
```
When the given argument is not valid json, `BankCredentials::Errors::Invalid` will be raised.

Attribute accessors are provided:
```ruby
credentials.pin        # => "pin"
credentials.url        # => "url"
credentials.user_id    # => "user_id"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/bank_credentials.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

