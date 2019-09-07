# frozen_string_literal: true

Factory.define(:service_data) do |f|
  f.key { fake(:lorem, :word) }
  f.payload { fake(:lorem, :paragraph) }
  f.chat_id { fake(:number, :between, 1, 100_000) }
end
