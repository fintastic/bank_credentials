$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'bankster/bank_credentials'
require 'byebug'

def valid_ebics_credentials
  {
    type:       'ebics',
    key:        'key',
    passphrase: 'passphrase',
    url:        'url',
    host_id:    'host_id',
    user_id:    'user_id',
    partner_id: 'partner_id'
  }
end

def valid_hbci_credentials
  {
    type:      'hbci',
    url:       'url',
    bank_code: 'bank_code',
    user_id:   'user_id',
    pin:       'pin'
  }
end
