# frozen_string_literal: true

module Persistence
  module Relations
    class ServiceData < ROM::Relation[:sql]
      schema :service_data do
        attribute :id, Types::Serial
        attribute :key, Types::String
        attribute :payload, Types::String
      end
    end
  end
end
