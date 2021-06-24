# frozen_string_literal: true

# Style/FrozenStringLiteralComment

require 'car'

RSpec.describe Car do
  describe '.style' do
    let(:hatchback) { build :car, :hatchback }
    let(:saloon) { build :car, :saloon }
    let(:suv) { build :car, :suv }
    it 'returns the correct style' do
      expect(hatchback.style).to eql(Car::HATCHBACK)
      expect(saloon.style).to eql(Car::SALOON)
      expect(suv.style).to eql(Car::SUV)
    end
  end
end
