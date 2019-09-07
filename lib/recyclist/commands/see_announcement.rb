# frozen_string_literal: true

require 'import'

module Recyclist
  module Commands
    class SeeAnnouncement
      NO_ANNOUNCEMENT = 'No announcement is found =('

      include Import[
        'recyclist.persistence.repositories.service_data'
      ]

      def call(message)
        main_data = service_data.by_key_and_chat_id('main', message.chat.id)

        if main_data
          main_data.payload
        else
          NO_ANNOUNCEMENT
        end
      end
    end
  end
end
