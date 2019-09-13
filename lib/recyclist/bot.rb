# frozen_string_literal: true

require 'telegram/bot'
require 'import'
require 'securerandom'

module Recyclist
  class Bot
    include Import[
      'recyclist.commands.i_want',
      'recyclist.commands.i_quit',
      'recyclist.commands.whos_in',
      'recyclist.commands.announce',
      'recyclist.commands.see_announcement',
      'recyclist.commands.clear',
      'logger'
    ]

    def start
      Telegram::Bot::Client.run(App[:settings].telegram_api_token) do |bot|
        bot.listen do |message|
          logger.warn message.text.inspect

          case message.text
          when /^\/i_want/
            response = i_want.call(message)
            bot.api.send_message(chat_id: message.chat.id, text: response)
          when /^\/i_quit/
            response = i_quit.call(message)
            bot.api.send_message(chat_id: message.chat.id, text: response)
          when /^\/whos_in/
            response = whos_in.call(message)
            bot.api.send_message(chat_id: message.chat.id, text: response)
          when /^\/announce.*/
            response = announce.call(message)
            bot.api.send_message(chat_id: message.chat.id, text: response)
          when /\/see_announcement.*/
            response = see_announcement.call(message)
            bot.api.send_message(chat_id: message.chat.id, text: response)
          when /^\/clear/
            response = clear.call(message)
            bot.api.send_message(chat_id: message.chat.id, text: response)
          end
        rescue StandardError => e
          logger.error e.inspect
        end
      end
    end
  end
end
