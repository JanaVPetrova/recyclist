# frozen_string_literal: true

require 'import'
require 'bigdecimal'

module Recyclist
  module Commands
    class WhosIn
      include Import[
        'recyclist.persistence.repositories.recyclists'
      ]

      MAGIC_PRICE = BigDecimal(1500)

      def call(message)
        nicknames = recyclists.
          by_chat_id(message.chat.id).
          map do |recyclist|
            full_name = present?(recyclist[:full_name]) ? "(#{recyclist[:full_name]})" : nil
            [recyclist[:nickname], full_name].compact.join(' ')
          end

        if nicknames.any?
          "#{nicknames.count} people are in:\n#{nicknames.join("\n")} \
          \n\n#{(MAGIC_PRICE / nicknames.count).to_s('F')} RUB per person"
        else
          'Nobody is in =('
        end
      end

      private

      def present?(value)
        !value.nil? && value != ''
      end
    end
  end
end
