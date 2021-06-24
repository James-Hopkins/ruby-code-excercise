# frozen_string_literal: true

FactoryBot.define do
  factory :driver do
    name { 'driver' }

    initialize_with { new(name) }
  end
end
