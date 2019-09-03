# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:service_data) do
      primary_key :id
      String :key, null: false
      String :payload, null: false

      index(:key, unique: true)
    end
  end
end
