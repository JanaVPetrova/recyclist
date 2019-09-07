# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Recyclist::Commands::Clear do
  subject(:clear) { App['recyclist.commands.clear'].call(message) }

  let(:message) do
    double(
      :message,
      from: double(:from, id: Faker::Number.between(1, 1000000), username: Faker::Name.first_name),
      chat: double(:chat, id: Faker::Number.between(1, 1000000))
    )
  end
  let!(:recyclist_from_other_chat) { Factory[:recyclist, chat_id: message.chat.id + 1].to_h }
  let(:recyclists) { App[:rom].relations[:recyclists].to_a }

  before do
    Factory[:recyclist, chat_id: message.chat.id, nickname: message.from.username]
  end

  it 'clears recyclists list' do
    clear

    expect(recyclists).to contain_exactly(recyclist_from_other_chat)
  end
end
