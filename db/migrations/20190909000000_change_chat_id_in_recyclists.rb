# frozen_string_literal: true

Sequel.migration do
  change do
    alter_table(:recyclists) do
      set_column_type :chat_id, String
    end
  end
end
