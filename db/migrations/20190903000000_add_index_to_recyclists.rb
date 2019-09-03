# frozen_string_literal: true

Sequel.migration do
  change do
    alter_table(:recyclists) do
      add_index(:user_id, unique: true)
    end
  end
end
