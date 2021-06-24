# frozen_string_literal: true

FactoryBot.define do
  factory :car do
    title { 'Hatchback Test' }
    style { Car::HATCHBACK }

    trait :hatchback do
      title { 'Hatchback Test' }
      style { Car::HATCHBACK }
    end

    trait :saloon do
      title { 'Saloon Test' }
      style { Car::SALOON }
    end

    trait :suv do
      title { 'SUV Test' }
      style { Car::SUV }
    end

    initialize_with { new(title, style) }
  end
end
