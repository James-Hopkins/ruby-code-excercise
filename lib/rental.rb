# frozen_string_literal: true

class Rental
  attr_reader :car, :days_rented

  def initialize(car, days_rented)
    @car = car
    @days_rented = days_rented

    raise 'Error: days_rented invalid' if @days_rented <= 0
  end

  def bonus_points
    @car.style == Car::SUV && @days_rented > 1 ? 2 : 1
  end

  def charge
    case @car.style
    when Car::HATCHBACK
      15 + daily_charge(3, 15).to_i
    when Car::SALOON
      20 + daily_charge(2, 15).to_i
    when Car::SUV
      0 + daily_charge(0, 30).to_i
    end
  end

  def daily_charge(free_days, rate)
    (@days_rented - free_days) * rate if @days_rented > free_days
  end
end
