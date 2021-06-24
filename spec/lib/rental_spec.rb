# frozen_string_literal: true

# Style/FrozenStringLiteralComment

require 'rental'

RSpec.describe Rental do
  it 'errors with days rented less than 1' do
    car = double('Car')
    expect { Rental.new(car, 0) }.to raise_error(RuntimeError, 'Error: days_rented invalid')
  end

  describe '.charge' do
    context 'rental car style is hatchback' do
      let(:hatchback1) { build :rental, :hatchback }
      let(:hatchback2) { build :rental, :hatchback, days_rented: 2 }
      let(:hatchback3) { build :rental, :hatchback, days_rented: 3 }
      let(:hatchback4) { build :rental, :hatchback, days_rented: 4 }
      let(:hatchback5) { build :rental, :hatchback, days_rented: 5 }
      let(:hatchback6) { build :rental, :hatchback, days_rented: 6 }

      it 'returns the correct charge' do
        expect(hatchback1.charge).to eql(15)
        expect(hatchback2.charge).to eql(15)
        expect(hatchback3.charge).to eql(15)
        expect(hatchback4.charge).to eql(30)
        expect(hatchback5.charge).to eql(45)
        expect(hatchback6.charge).to eql(60)
      end
    end

    context 'rental car style is saloon' do
      let(:saloon1) { build :rental, :saloon }
      let(:saloon2) { build :rental, :saloon, days_rented: 2 }
      let(:saloon3) { build :rental, :saloon, days_rented: 3 }
      let(:saloon4) { build :rental, :saloon, days_rented: 4 }
      let(:saloon5) { build :rental, :saloon, days_rented: 5 }
      let(:saloon6) { build :rental, :saloon, days_rented: 6 }

      it 'returns the correct charge' do
        expect(saloon1.charge).to eql(20)
        expect(saloon2.charge).to eql(20)
        expect(saloon3.charge).to eql(35)
        expect(saloon4.charge).to eql(50)
        expect(saloon5.charge).to eql(65)
        expect(saloon6.charge).to eql(80)
      end
    end

    context 'rental car style is suv' do
      let(:suv1) { build :rental, :suv }
      let(:suv2) { build :rental, :suv, days_rented: 2 }
      let(:suv3) { build :rental, :suv, days_rented: 3 }
      let(:suv4) { build :rental, :suv, days_rented: 4 }
      let(:suv5) { build :rental, :suv, days_rented: 5 }
      let(:suv6) { build :rental, :suv, days_rented: 6 }

      it 'returns the correct charge' do
        expect(suv1.charge).to eql(30)
        expect(suv2.charge).to eql(60)
        expect(suv3.charge).to eql(90)
        expect(suv4.charge).to eql(120)
        expect(suv5.charge).to eql(150)
        expect(suv6.charge).to eql(180)
      end
    end
  end

  describe '.daily_charge' do
    let(:hatchback) { build :rental, :hatchback, days_rented: 2 }
    it 'returns the rate multiplied by days rented minus the free days' do
      expect(hatchback.daily_charge(0, 25)).to eql(50)
      expect(hatchback.daily_charge(1, 25)).to eql(25)
    end

    it 'returns nil if free days are greater than or equal to days rented' do
      expect(hatchback.daily_charge(2, 25)).to eql(nil)
      expect(hatchback.daily_charge(3, 25)).to eql(nil)
    end
  end

  describe '.bonus_points' do
    let(:hatchback) { build :rental, :hatchback }
    let(:saloon) { build :rental, :saloon }
    let(:suv) { build :rental, :suv }
    let(:suv2) { build :rental, :suv, days_rented: 2 }

    it 'returns the correct bonus points' do
      expect(hatchback.bonus_points).to eql(1)
      expect(saloon.bonus_points).to eql(1)
      expect(suv.bonus_points).to eql(1)
      expect(suv2.bonus_points).to eql(2)
    end
  end
end
