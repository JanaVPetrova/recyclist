# frozen_string_literal: true

require 'recyclist/repository'
require 'persistence/relations/recyclists'

module Recyclist
  module Persistence
    module Repositories
      class ServiceData < Recyclist::Repository[:service_data]
        commands :create

        def by_key(key)
          service_data.where(key: key.to_s).one
        end

        def update_key(key:, payload:)
          service_data.where(key: key).update(payload: payload)
        end
      end
    end
  end
end
