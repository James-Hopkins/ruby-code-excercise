# frozen_string_literal: true

# Style/FrozenStringLiteralComment

require 'driver'
require 'car'
require 'rental'

RSpec.describe Driver do
  describe '.add_rental' do
    let(:driver) { build :driver }
    let(:rental) { build :rental, :hatchback }
    let(:car) { build :car }
    it 'adds a rental to a driver' do
      driver.add_rental(rental)
      rentals = driver.instance_variable_get(:@rentals)
      expect(rentals[0]).to eql(rental)
    end

    it 'disallows anything to be added as a rental' do
      expect { driver.add_rental('a string') }.to raise_error(TypeError)
      expect { driver.add_rental(27) }.to raise_error(TypeError)
      expect { driver.add_rental(Car) }.to raise_error(TypeError)
    end
  end

  describe '.statement' do
    let(:driver) { build :driver }
    let(:hatchback) { build :rental, :hatchback }
    let(:saloon) { build :rental, :saloon }
    let(:suv) { build :rental, :suv }
    it 'builds a statement from a valid driver' do
      expect(driver.statement).to eq(
        "Car rental record for driver\n" \
          "Amount owed is €0\n" \
          'Earned bonus points: 0'
      )
    end

    it 'builds a statement from a valid driver with rentals' do
      driver.add_rental(hatchback)
      driver.add_rental(saloon)
      driver.add_rental(suv)
      expect(driver.statement).to eq(
        "Car rental record for driver\n" \
          "Hatchback Test,15\n" \
          "Saloon Test,20\n" \
          "SUV Test,30\n" \
          "Amount owed is €65\n" \
          'Earned bonus points: 3'
      )
    end
  end

  describe '.json_statement' do
    # TODO: Add tests for method, the end to end test below will test this
    # functionality but i would prefer it in the specification style i've tried
    # to adhere to. I have spent a little too much time on this excercise and
    # would like to move on. - James Hopkins
  end

  describe 'end to end test for creating driver statements' do
    context 'Driver has multiple rentals' do
      saloon1 = Car.new('Audi A3', Car::SALOON)
      suv1 = Car.new('BMW X1', Car::SUV)
      driver = Driver.new('Bill Simpson')
      driver.add_rental(Rental.new(suv1, 2))
      driver.add_rental(Rental.new(saloon1, 2))
      statement = driver.statement
      json_statement = driver.json_statement

      statement_json_file = File.read('fixtures/statement.json')
      json_hash = JSON.parse(statement_json_file)

      it 'returns a valid statement' do
        expect(statement).to eq(
          "Car rental record for Bill Simpson\n" \
            "BMW X1,60\n" \
            "Audi A3,20\n" \
            "Amount owed is €80\n" \
            'Earned bonus points: 3'
        )
      end

      it 'returns a valid json statement' do
        expect(json_statement).to match_json_schema('statement')
        expect(json_statement).to eq(json_hash.to_json)
      end
    end
  end
end
