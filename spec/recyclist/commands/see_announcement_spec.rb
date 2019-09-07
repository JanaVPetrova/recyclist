# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Recyclist::Commands::SeeAnnouncement do
  subject(:see_announcement) { App['recyclist.commands.see_announcement'].call(message) }

  let(:message) do
    double(
      :message,
      from: double(:from, id: Faker::Number.between(1, 1000000), username: Faker::Name.first_name),
      chat: double(:chat, id: Faker::Number.between(1, 1000000))
    )
  end

  context "when 'main' data exists" do
    let!(:main_data) { Factory[:service_data, chat_id: message.chat.id, key: 'main'] }

    it 'shows its payload' do
      expect(see_announcement).to eq main_data.payload
    end
  end

  context "when 'main' data does not exist" do
    it 'shows no data message' do
      expect(see_announcement).to eq described_class::NO_ANNOUNCEMENT
    end
  end
end
