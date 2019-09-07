# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Recyclist::Commands::Announce do
  subject(:announce) { App['recyclist.commands.announce'].call(message) }

  let(:message) do
    double(
      :message,
      from: double(:from, id: Faker::Number.between(1, 1000000), username: Faker::Name.first_name),
      chat: double(:chat, id: Faker::Number.between(1, 1000000)),
      text: "/announce@recyclist_bot #{announcement}"
    )
  end
  let(:announcement) { Faker::Lorem.paragraph }
  let(:main_data) do
    App[:rom].relations[:service_data].where(key: 'main').first.slice(:chat_id, :payload)
  end

  context "when 'main' data exists" do
    before do
      Factory[:service_data, chat_id: message.chat.id, key: 'main']
    end

    it 'changes its payload' do
      announce

      expect(main_data).to eq(chat_id: message.chat.id, payload: announcement)
    end
  end

  context "when 'main' data does not exist" do
    it 'changes its payload' do
      announce

      expect(main_data).to eq(chat_id: message.chat.id, payload: announcement)
    end
  end
end
