# frozen_string_literal: true

Sequel.migration do
  change do
    alter_table(:recyclists) do
      drop_index(:user_id)
      add_index([:user_id, :chat_id], uniq: true)
    end
  end
end
