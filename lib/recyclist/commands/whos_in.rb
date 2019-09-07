# frozen_string_literal: true

require 'import'

module Recyclist
  module Commands
    class WhosIn
      include Import[
        'recyclist.persistence.repositories.recyclists'
      ]

      def call(message)
        nicknames = recyclists.
          by_chat_id(message.chat.id).
          map { |recyclist| recyclist[:nickname] }

        if nicknames.any?
          "#{nicknames.count} people are in:\n#{nicknames.join("\n")}"
        else
          'Nobody is in =('
        end
      end
    end
  end
end
