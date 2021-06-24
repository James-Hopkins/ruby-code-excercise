# frozen_string_literal: true

FactoryBot.define do
  factory :rental do
    car { Car.new }
    days_rented { 1 }

    trait :hatchback do
      car { Car.new('Hatchback Test', Car::HATCHBACK) }
    end

    trait :saloon do
      car { Car.new('Saloon Test', Car::SALOON) }
    end

    trait :suv do
      car { Car.new('SUV Test', Car::SUV) }
    end

    initialize_with { new(car, days_rented) }
  end
end
