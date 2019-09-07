# frozen_string_literal: true

require 'import'

module Recyclist
  module Commands
    class Clear
      include Import[
        'recyclist.persistence.repositories.recyclists'
      ]

      def call(message)
        recyclists.delete_all(message.chat.id)
        'Recyclists list is empty'
      end
    end
  end
end
