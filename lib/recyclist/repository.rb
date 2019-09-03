# frozen_string_literal: true

# auto_register: false

require 'rom-repository'
require 'container'
require 'import'

module Recyclist
  class Repository < ROM::Repository::Root
    include Import.args[:rom]
  end
end
