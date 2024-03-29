# frozen_string_literal: true

module ONSJWE
  module Version
    MAJOR = 1
    MINOR = 2
    TINY  = 0
  end
  VERSION = [Version::MAJOR, Version::MINOR, Version::TINY].compact * '.'
end
