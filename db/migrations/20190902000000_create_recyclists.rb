# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:recyclists) do
      primary_key :id
      String :uuid, null: false
      String :nickname, null: false
      String :user_id, null: false
    end
  end
end
