# frozen_string_literal: true

require 'import'

module Recyclist
  module Commands
    class IWant
      include Import[
        'recyclist.persistence.repositories.recyclists'
      ]

      def call(message)
        if recyclists.by_user_id_and_chat_id(message.from.id, message.chat.id)
          'Oops, you are already in'
        else
          recyclist = recyclists.create(
            user_id: message.from.id,
            nickname: message.from.username,
            full_name: [message.from.first_name, message.from.last_name].join(' '),
            chat_id: message.chat.id,
            uuid: SecureRandom.uuid
          )
          "Yey! #{recyclist.nickname} joined! Now #{recyclists.by_chat_id(message.chat.id).count} people are in"
        end
      end
    end
  end
end
