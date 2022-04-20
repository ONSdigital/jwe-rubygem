# frozen_string_literal: true

require 'date'

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

  s.add_runtime_dependency 'json-jwt'
  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'test-unit'
end
