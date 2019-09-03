# frozen_string_literal: true

ENV['APP_ENV'] ||= 'development'

require_relative 'container'

App.finalize!
