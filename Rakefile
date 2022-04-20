#!/usr/bin/env rake
# frozen_string_literal: true

require 'rake/testtask'
require_relative 'lib/ons-jwe/version'

task default: :test

desc 'Build the gem'
task build: [:test] do
  system('gem build ons-jwe.gemspec')
end

desc 'Push the gem to the Gem In A Box server'
task release: [:build] do
  system("gem inabox ons-jwe-#{ONSJWE::VERSION}.gem")
end

Rake::TestTask.new do |t|
  # Suppress a bunch of warnings from the ActiveSupport gem.
  t.warning = false
  t.pattern = 'test/*_test.rb'
end
