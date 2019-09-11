# frozen_string_literal: true

Sequel.migration do
  change do
    alter_table(:recyclists) do
      add_column(:full_name, String)
    end
  end
end
