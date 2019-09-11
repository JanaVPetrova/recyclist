# frozen_string_literal: true

Factory.define(:recyclist) do |f|
  f.user_id { fake(:number, :between, 1, 100_000) }
  f.chat_id { fake(:number, :between, 1, 100_000) }
  f.nickname { fake(:name) }
  f.uuid { SecureRandom.uuid }
  f.full_name { fake(:name) }
end
