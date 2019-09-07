# frozen_string_literal: true

require 'rom-factory'

Factory = ROM::Factory.configure do |config|
  config.rom = App[:rom]
end

Dir[File.join(App.root, 'spec/factories/**/*.rb')].each { |f| require f }
