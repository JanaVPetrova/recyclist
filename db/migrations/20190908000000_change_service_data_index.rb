# frozen_string_literal: true

Sequel.migration do
  change do
    alter_table(:service_data) do
      drop_index(:key)
      add_index([:key, :chat_id], uniq: true)
    end
  end
end
