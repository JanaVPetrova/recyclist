# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Recyclist::Commands::IQuit do
  subject(:i_quit) { App['recyclist.commands.i_quit'].call(message) }

  let(:message) do
    double(
      :message,
      from: double(:from, id: Faker::Number.between(1, 1000000), username: Faker::Name.first_name),
      chat: double(:chat, id: Faker::Number.between(1, 1000000))
    )
  end
  let(:recyclists) { App[:rom].relations[:recyclists].to_a }

  context 'when recyclist exists' do
    before do
      Factory[:recyclist, user_id: message.from.id, chat_id: message.chat.id, nickname: message.from.username]
    end

    it 'removes existing recyclist' do
      i_quit

      expect(recyclists).to be_empty
    end
  end

  context 'when recyclist doen not exist' do
    it 'does nothing' do
      expect { i_quit }.not_to raise_error
    end
  end
end
