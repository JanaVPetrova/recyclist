# frozen_string_literal: true

module Persistence
  module Relations
    class Recyclists < ROM::Relation[:sql]
      schema :recyclists do
        attribute :id, Types::Serial
        attribute :user_id, Types::Int
        attribute :chat_id, Types::Int
        attribute :uuid, Types::String
        attribute :nickname, Types::String.optional
        attribute :full_name, Types::String.optional
      end
    end
  end
end
