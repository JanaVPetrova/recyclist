# frozen_string_literal: true

module Types
  include Dry::Types.module

  module Env
    Array = Types::Strict::Array.constructor { |value| value.split(',') }
  end
end
