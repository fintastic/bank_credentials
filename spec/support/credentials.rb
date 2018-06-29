# frozen_string_literal: true

def valid_ebics_credentials
  valid_ebics_credentials_with_type
end

def valid_ebics_credentials_without_type
  {
    key:        'key',
    passphrase: 'passphrase',
    url:        'https://localhost',
    host_id:    'host_id',
    user_id:    'user_id',
    partner_id: 'partner_id'
  }
end

def valid_ebics_credentials_with_type
  valid_ebics_credentials_without_type.merge(type: 'ebics')
end

def valid_hbci_credentials
  valid_hbci_credentials_with_type
end

def valid_hbci_credentials_without_type
  {
    url:       'url',
    bank_code: 'bank_code',
    user_id:   'user_id',
    pin:       'pin'
  }
end

def valid_hbci_credentials_with_type
  valid_hbci_credentials_without_type.merge(type: 'hbci')
end
