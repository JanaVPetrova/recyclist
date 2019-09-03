# frozen_string_literal: true

require 'bundler/setup'
require_relative 'system/container'

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new :spec
  task default: [:spec]
rescue LoadError
  nil
end

Rake.add_rakelib 'lib/tasks'

task :environment do
  App.finalize!
end

task :settings do
  App.start(:settings)
end
