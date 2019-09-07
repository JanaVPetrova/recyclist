# frozen_string_literal: true

require 'import'

module Recyclist
  module Commands
    class Announce
      include Import[
        'recyclist.persistence.repositories.service_data'
      ]

      def call(message)
        match = message.text.match(/\/announce(?:@recyclist_bot)*\s*(?<announcement>(.*))$/)
        return unless match

        announcement = match['announcement']
        if service_data.by_key_and_chat_id('main', message.chat.id)
          service_data.update_key(key: 'main', chat_id: message.chat.id, payload: announcement)
        else
          service_data.create(key: 'main', chat_id: message.chat.id, payload: announcement)
        end

        "Ok! #{announcement}"
      end
    end
  end
end
