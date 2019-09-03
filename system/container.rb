# frozen_string_literal: true

require 'dry/system/container'
require 'dry/system/components'
require 'logger'

class App < Dry::System::Container
  use :env, inferrer: -> { ENV.fetch('APP_ENV', 'development').to_sym }
  use :logging

  configure do |config|
    config.auto_register = %w[lib apps]

    logger_destination = config.env == :test ? 'log/test.log' : STDOUT
    config.logger = Logger.new(logger_destination)
  end

  load_paths!('lib')
end
