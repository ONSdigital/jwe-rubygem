# frozen_string_literal: true

require 'json/jwt'

# This class generates JSON Web Encryption (JWE) tokens as per RFC 7516.
class JWEToken
  attr_reader :value

  def initialize(key_id, claims, public_key, private_key)
    validate_key_id(key_id)
    validate_claims(claims)
    validate_public_key(public_key)
    validate_private_key(private_key)
    jwt    = build_jwt(claims, key_id)
    jws    = build_jws(jwt, private_key)
    @value = build_jwe(jws, public_key).to_s
  end

  def to_s
    @value
  end

  private

  def build_jwe(jws, public_key)
    jws.encrypt(public_key, :'RSA-OAEP', :A256GCM)
  end

  def build_jwt(claims, key_id)
    jwt = JSON::JWT.new(claims)
    jwt.kid = key_id
    jwt.alg = :RS256
    jwt
  end

  def build_jws(jwt, private_key)
    jwt.sign(private_key, :RS256)
  end

  def validate_claims(claims)
    raise ArgumentError, 'claims must be specified' if claims.nil? ||
                                                       claims.empty?
  end

  def validate_key_id(key_id)
    raise ArgumentError, 'key_id must be specified' if key_id.nil? ||
                                                       key_id.empty?
  end

  def validate_private_key(private_key)
    raise ArgumentError, 'private_key must be specified' if private_key.nil?

    validate_rsa_key(private_key, 'private_key')
  end

  def validate_public_key(public_key)
    raise ArgumentError, 'public_key must be specified' if public_key.nil?

    validate_rsa_key(public_key, 'public_key')
  end

  def validate_rsa_key(key, key_type)
    raise ArgumentError, "#{key_type} must be an RSA key" unless key.instance_of? OpenSSL::PKey::RSA
  end
end
