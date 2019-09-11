# frozen_string_literal: true

Sequel.migration do
  change do
    alter_table(:recyclists) do
      set_column_allow_null :nickname
    end
  end
end
