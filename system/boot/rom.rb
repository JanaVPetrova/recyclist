# frozen_string_literal: true

App.boot(:rom) do |container|
  init do
    require 'pg'
    require 'sequel'
    require 'rom-sql'
    use :settings

    Sequel.database_timezone = :utc
    Sequel.application_timezone = :utc
  end

  start do
    opts = {
      username: container[:settings].db_username,
      password: container[:settings].db_password
    }

    host = container[:settings].db_host
    port = container[:settings].db_port
    database = container[:settings].db_database

    config = ROM::Configuration.new(:sql, "postgres://#{host}:#{port}/#{database}", opts)
    config.auto_registration container.root.join('lib/persistence')
    config.gateways[:default].use_logger(logger)

    register :rom_config, config
    register :db_connection, config.gateways[:default].connection
    register :rom, ROM.container(config)
  end
end
