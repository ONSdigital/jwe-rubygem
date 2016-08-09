# frozen_string_literal: true
require_relative 'lib/ons-jwe/version'

Gem::Specification.new do |s|
  s.name        = 'ons-jwe'
  s.version     = ONSJWE::VERSION
  s.date        = Date.today.to_s
  s.summary     = 'JSON Web Encryption (JWE) token generator'
  s.description = <<~DESC
    RFC7516-compliant JSON Web Encryption (JWE) token generator that uses RSAES-OAEP and AES GCM.
    Suitable for use with the ONS eQ Survey Runner.
  DESC
  s.authors     = ['John Topley']
  s.email       = ['john.topley@ons.gov.uk']
  s.files       = ['README.md']
  s.files      += Dir['lib/**/*.rb']
  s.homepage    = 'https://github.com/ONSdigital/jwe-rubygem'
  s.license     = 'Crown Copyright (Office for National Statistics)'

  s.add_runtime_dependency 'json-jwt', '~>1', '>= 1.6.3'
  s.add_development_dependency 'rake', '~>11', '>=11.1.2'
  s.add_development_dependency 'rubocop', '~>0', '>=0.42.0'
  s.add_development_dependency 'test-unit', '~>3', '>=3.1.9'
end
