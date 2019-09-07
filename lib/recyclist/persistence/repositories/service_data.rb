# frozen_string_literal: true

require 'recyclist/repository'
require 'persistence/relations/recyclists'

module Recyclist
  module Persistence
    module Repositories
      class ServiceData < Recyclist::Repository[:service_data]
        commands :create

        def by_key_and_chat_id(key, chat_id)
          service_data.where(key: key.to_s, chat_id: chat_id.to_s).one
        end

        def update_key(key:, payload:, chat_id:)
          service_data.where(key: key, chat_id: chat_id.to_s).update(payload: payload)
        end
      end
    end
  end
end
