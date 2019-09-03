# frozen_string_literal: true

Sequel.migration do
  change do
    alter_table(:recyclists) do
      add_column(:chat_id, Integer, null: false)
    end
  end
end
