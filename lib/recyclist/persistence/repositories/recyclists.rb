# frozen_string_literal: true

require 'recyclist/repository'
require 'persistence/relations/recyclists'

module Recyclist
  module Persistence
    module Repositories
      class Recyclists < Recyclist::Repository[:recyclists]
        commands :create, delete: :by_pk

        def by_user_id_and_chat_id(user_id, chat_id)
          recyclists.where(user_id: user_id.to_s, chat_id: chat_id).one
        end

        def by_chat_id(chat_id)
          recyclists.where(chat_id: chat_id)
        end

        def delete_all(chat_id)
          recyclists.where(chat_id: chat_id).delete
        end
      end
    end
  end
end
