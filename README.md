# ONS JSON Web Token RubyGem
[RFC 7516](https://tools.ietf.org/html/rfc7516)-compliant JSON Web Encryption (JWE) token generator that uses RSAES-OAEP and AES GCM. Suitable for use with the [ONS eQ Survey Runner](https://github.com/ONSdigital/eq-survey-runner). Note that this gem targets Ruby 2.3 and above.

## Installation

```
gem install ons-jwe
```

## Examples

```ruby
require 'openssl'
require 'ons-jwe'

KEY_ID = 'EDCRRM'

RESPONDENT_PORTAL_PRIVATE_KEY = File.read('sdc-user-authentication-signing-rrm-private-key.pem')
SURVEY_RUNNER_PUBLIC_KEY      = File.read('sdc-user-authentication-encryption-sr-public-key.pem')

public_key  = OpenSSL::PKey::RSA.new(SURVEY_RUNNER_PUBLIC_KEY)
private_key = OpenSSL::PKey::RSA.new(RESPONDENT_PORTAL_PRIVATE_KEY, 'digitaleq')

claims = {
  user_id: 'John Topley',
  iat: Time.now.to_i,
  exp: Time.now.to_i + 60 * 60,
  eq_id: '1',
  period_str: '2016-01-01',
  period_id: '2016-01-01',
  form_type: '0205',
  collection_exercise_sid: '789',
  ref_p_start_date: '2016-01-01',
  ref_p_end_date: '2016-09-01',
  ru_ref: '12346789012A',
  ru_name: 'Office for National Statistics',
  return_by: '2016-04-30',
  employment_date: '2016-06-10'
}

token = JWEToken.new(KEY_ID, claims, public_key, private_key)
puts token.value
```

## Testing

```
rake test
```

## Copyright
Copyright (C) 2016 Crown Copyright (Office for National Statistics)
