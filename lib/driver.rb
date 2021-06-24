# frozen_string_literal: true

require 'byebug'
require 'json'

# Public: Various methods attributed to the driver object,
#  a driver has a name and may have many rentals assigned to it.
class Driver
  attr_reader :name

  def initialize(name)
    @name = name
    @rentals = []
  end

  def add_rental(rental)
    rental.is_a?(Rental) ? @rentals << rental : raise(TypeError)
  end

  def statement
    bonus_points = 0
    total = 0
    result = "Car rental record for #{@name}\n"

    @rentals.each do |rental|
      bonus_points += rental.bonus_points
      this_amount = rental.charge
      result += "#{rental.car.title},#{this_amount}\n"
      total += this_amount
    end

    result += "Amount owed is €#{total}\n"
    result += "Earned bonus points: #{bonus_points}"
    result
  end

  # Public: Creates a JSON statement based on a driver.
  #
  # Examples
  #
  #   saloon1 = Car.new('Audi A3', Car::SALOON)
  #   suv1 = Car.new('BMW X1', Car::SUV)
  #   driver = Driver.new('Bill Simpson')
  #   driver.add_rental(Rental.new(suv1, 2))
  #   driver.add_rental(Rental.new(saloon1, 2))
  #   json_statement = driver.json_statement
  #   # => {
  #     "customer_name": "name",
  #     "car_rentals": [
  #       {
  #         "days_rented": 1,
  #         "car": "car_title",
  #         "total_cost": 20
  #       }
  #     ]
  #     "total_payable": "€",
  #     "bonus_points": 1
  #   }
  # Returns a JSON representation of the statement.
  def json_statement
    total = 0
    bonus_points = 0
    json_statement = {
      customer_name: @name,
      car_rentals: @rentals.map do |rental|
        this_amount = rental.charge
        total += this_amount
        bonus_points += rental.bonus_points
        {
          days_rented: rental.days_rented,
          car: rental.car.title,
          total_cost: this_amount
        }
      end
    }
    json_statement[:total_payable] = "€#{total}"
    json_statement[:bonus_points] = bonus_points
    json_statement.to_json
  end
end
