# frozen_string_literal: true

require 'test/unit'
require 'openssl'

require_relative '../lib/ons-jwe/jwe_token'

class JWETokenTest < Test::Unit::TestCase
  VALID_JWE_HEADER = 'eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZHQ00ifQ'

  KEY_ID = 'TestKey'

  # rubocop:disable Style/MutableConstant
  CLAIMS = {
    iat: Time.now.to_i,
    exp: Time.now.to_i + 60 * 60
  }
  # rubocop:enable Style/MutableConstant

  def setup
    @public_key  = load_key_from_file('fixtures/public_key.pem')
    @private_key = load_key_from_file('fixtures/private_key.pem', 'digitaleq')
  end

  def test_token_has_valid_header
    token = JWEToken.new(KEY_ID, CLAIMS, @public_key, @private_key)
    assert_equal VALID_JWE_HEADER, extract_header(token.value)
  end

  def test_empty_claims_raises_argument_error
    exception = assert_raise ArgumentError do
      JWEToken.new(KEY_ID, {}, @public_key, @private_key)
    end
    assert_equal 'claims must be specified', exception.message
  end

  def test_empty_key_id_raises_argument_error
    exception = assert_raise ArgumentError do
      JWEToken.new('', CLAIMS, @public_key, @private_key)
    end
    assert_equal 'key_id must be specified', exception.message
  end

  def test_nil_claims_raises_argument_error
    exception = assert_raise ArgumentError do
      JWEToken.new(KEY_ID, nil, @public_key, @private_key)
    end
    assert_equal 'claims must be specified', exception.message
  end

  def test_nil_key_id_raises_argument_error
    exception = assert_raise ArgumentError do
      JWEToken.new(nil, CLAIMS, @public_key, @private_key)
    end
    assert_equal 'key_id must be specified', exception.message
  end

  def test_nil_private_key_raises_argument_error
    exception = assert_raise ArgumentError do
      JWEToken.new(KEY_ID, CLAIMS, @public_key, nil)
    end
    assert_equal 'private_key must be specified', exception.message
  end

  def test_nil_public_key_raises_argument_error
    exception = assert_raise ArgumentError do
      JWEToken.new(KEY_ID, CLAIMS, nil, @private_key)
    end
    assert_equal 'public_key must be specified', exception.message
  end

  def test_non_rsa_private_key_raises_argument_error
    exception = assert_raise ArgumentError do
      JWEToken.new(KEY_ID, CLAIMS, @public_key, 'not an RSA key')
    end
    assert_equal 'private_key must be an RSA key', exception.message
  end

  def test_non_rsa_public_key_raises_argument_error
    exception = assert_raise ArgumentError do
      JWEToken.new(KEY_ID, CLAIMS, 'not an RSA key', @private_key)
    end
    assert_equal 'public_key must be an RSA key', exception.message
  end

  private

  def extract_header(token_value)
    token_value[0, token_value.index('.')]
  end

  def load_key_from_file(file, passphrase = nil)
    OpenSSL::PKey::RSA.new(File.read(File.join(__dir__, file)), passphrase)
  end
end
