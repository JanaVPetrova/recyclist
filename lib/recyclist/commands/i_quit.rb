# frozen_string_literal: true

require 'import'

module Recyclist
  module Commands
    class IQuit
      include Import[
        'recyclist.persistence.repositories.recyclists'
      ]

      def call(message)
        recyclist = recyclists.by_user_id_and_chat_id(message.from.id, message.chat.id)
        if recyclist
          recyclists.delete(recyclist.id)
          "Recyclist #{recyclist.nickname} changed his/her mind =("
        else
          "Recyclist #{message.from.username} was not in the list anyway =/ "
        end
      end
    end
  end
end
