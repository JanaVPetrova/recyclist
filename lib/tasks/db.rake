# frozen_string_literal: true

namespace :db do
  desc 'Create database and load structure'
  task create: :settings do
    require 'pg'
    require 'sequel'

    opts = {
      username: App[:settings].db_username,
      password: App[:settings].db_password,
      flags: Mysql2::Client::MULTI_STATEMENTS
    }

    host = App[:settings].db_host
    port = App[:settings].db_port

    connection_string = "postgres://#{host}:#{port}/"

    Sequel.
      connect(connection_string, opts).
      execute("CREATE DATABASE IF NOT EXISTS #{App[:settings].db_database}")
  end

  desc 'Run migrations'
  task :migrate, [:version] => :setup do |_t, args|
    require 'pg'
    require 'sequel'
    Sequel.extension :migration

    if args[:version]
      App[:logger].info("Migrating to version #{args[:version]}")
      Sequel::Migrator.run(App[:db_connection], 'db/migrations', target: args[:version].to_i)
    else
      App[:logger].info('Migrating to latest')
      Sequel::Migrator.run(App[:db_connection], 'db/migrations')
    end
  end

  task :setup do
    App.start(:rom)
  end
end
