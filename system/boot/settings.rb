# frozen_string_literal: true

App.boot :settings, from: :system do
  before :init do
    require_from_root 'lib/types'
  end

  settings do
    key :db_database, Types::String.constrained(filled: true)
    key :db_host, Types::String.constrained(filled: true)
    key :db_port, Types::String.constrained(filled: true)
    key :db_username, Types::String.constrained(filled: true)
    key :db_password, Types::String.optional
    key :telegram_api_token, Types::String.constrained(filled: true)
  end
end
