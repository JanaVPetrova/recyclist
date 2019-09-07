# frozen_string_literal: true

require 'telegram/bot'
require 'import'
require 'securerandom'
require 'pry-byebug'

module Recyclist
  class Bot
    include Import[
      'recyclist.persistence.repositories.recyclists',
      'recyclist.persistence.repositories.service_data',
      'logger'
    ]

    def start
      Telegram::Bot::Client.run(App[:settings].telegram_api_token) do |bot|
        bot.listen do |message|
          logger.warn message.text.inspect

          case message.text
          when /^\/start/
            text = "The next EcoTaxy arrives tomorrow. Type '/i_want' to participate, '/help' for more actions"
            bot.api.send_message(chat_id: message.chat.id, text: text)
          when /^\/help/
            text = <<~TEXT
              '/help' - see this message
              '/i_want' - participate in the upcoming Recycling Event
              '/i_quit' - cancel participation in the upcoming Recycling Event
              '/announce My Shiny Announcement' - announce a new event
              '/whos_in' - see the list of participants
              '/clear' - [DANGEROUS] remove all participants from the upcoming Recycling Event.
            TEXT
            bot.api.send_message(chat_id: message.chat.id, text: text)
          when /^\/i_want/
            if recyclists.by_user_id_and_chat_id(message.from.id, message.chat.id)
              bot.api.send_message(chat_id: message.chat.id, text: "Oops, you are already in")
            else
              recyclist = recyclists.create(
                user_id: message.from.id,
                nickname: message.from.username,
                chat_id: message.chat.id,
                uuid: SecureRandom.uuid
              )
              bot.api.send_message(chat_id: message.chat.id, text: "Yey! #{recyclist.nickname} joined!")
            end
          when /^\/i_quit/
            logger.warn('XXX')
            recyclist = recyclists.by_user_id(message.from.id)
            recyclists.delete(recyclist.id)
            bot.api.send_message(chat_id: message.chat.id, text: "Recyclist #{recyclist.nickname} changed his/her mind =(")
          when /^\/announce .*/
            match = message.text.match(/\/announce (?<announcement>.*)/)
            return unless match

            announcement = match['announcement']
            if service_data.by_key('main')
              service_data.update_key(key: 'main', payload: announcement)
            else
              service_data.create(key: 'main', payload: announcement)
            end
            bot.api.send_message(chat_id: message.chat.id, text: "Ok! #{announcement}")
          when /^\/whos_in/
            nicknames = recyclists.
              by_chat_id(message.chat.id).
              map { |recyclist| recyclist[:nickname] }

            if nicknames.any?
              bot.api.send_message(chat_id: message.chat.id, text: "#{nicknames.count} people are in:\n#{nicknames.join("\n")}")
            else
              bot.api.send_message(chat_id: message.chat.id, text: "Nobody is in =(")
            end
          when /^\/clear/
            recyclists.delete_all
            bot.api.send_message(chat_id: message.chat.id, text: 'Recyclists list is empty.')
          end
        rescue StandardError => e
          logger.error e.inspect
        end
      end
    end
  end
end
