# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Recyclist::Commands::IWant do
  subject(:i_want) { App['recyclist.commands.i_want'].call(message) }

  let(:message) do
    double(
      :message,
      from: double(:from, id: Faker::Number.between(1, 1000000), username: Faker::Name.first_name),
      chat: double(:chat, id: Faker::Number.between(1, 1000000))
    )
  end
  let(:recyclists) do
    App[:rom].relations[:recyclists].to_a.map { |row| row.to_h.slice(:user_id, :chat_id, :nickname) }
  end

  it 'creates new recyclist' do
    i_want

    expect(recyclists).to contain_exactly(
      user_id: message.from.id.to_s,
      chat_id: message.chat.id,
      nickname: message.from.username
    )
  end
end
