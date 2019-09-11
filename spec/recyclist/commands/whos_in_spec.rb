# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Recyclist::Commands::WhosIn do
  subject(:whos_in) { App['recyclist.commands.whos_in'].call(message) }

  let(:message) do
    double(
      :message,
      chat: double(:chat, id: Faker::Number.between(1, 1000000))
    )
  end
  before do
    Factory[:recyclist, chat_id: message.chat.id, ]
    Factory[:recyclist, chat_id: message.chat.id, full_name: nil]
    Factory[:recyclist, chat_id: message.chat.id, full_name: '']
  end

  it 'creates new recyclist' do
    puts whos_in
  end
end
