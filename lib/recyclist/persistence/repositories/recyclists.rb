# frozen_string_literal: true

require 'recyclist/repository'
require 'persistence/relations/recyclists'

module Recyclist
  module Persistence
    module Repositories
      class Recyclists < Recyclist::Repository[:recyclists]
        commands :create, delete: :by_pk

        def by_user_id(user_id)
          recyclists.where(user_id: user_id.to_s).one
        end

        def by_chat_id(chat_id)
          recyclists.where(chat_id: chat_id)
        end

        def clear
          recyclists.delete
        end
      end
    end
  end
end
