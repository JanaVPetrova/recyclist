# frozen_string_literal: true

module Persistence
  module Relations
    class Recyclists < ROM::Relation[:sql]
      schema :recyclists do
        attribute :id, Types::Serial
        attribute :user_id, Types::Int
        attribute :chat_id, Types::Int
        attribute :uuid, Types::String
        attribute :nickname, Types::Int.optional
      end
    end
  end
end
