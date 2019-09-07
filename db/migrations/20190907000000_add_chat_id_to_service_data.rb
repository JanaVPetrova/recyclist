# frozen_string_literal: true

Sequel.migration do
  change do
    alter_table(:service_data) do
      add_column(:chat_id, Integer, null: false)
    end
  end
end
