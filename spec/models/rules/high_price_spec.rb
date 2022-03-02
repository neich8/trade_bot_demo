require 'rails_helper'

RSpec.describe Rules::HighPrice do
  context 'sell' do
    let(:trade) { build(:trade, unit_type: 'fake', price_per_unit: 125, fee: 5, unit_count: 1) }
    context 'no' do
      let(:data) { build(:decidor_attribute, trade: trade, average_cost_with_fees: 130, average_cost_without_fees: 100) }

      it 'returns false if price is lower' do
        balance = described_class.new(data)
        expect(balance.sell).to eq(false)
      end
    end

    context 'yes' do
      let(:data) { build(:decidor_attribute, trade: trade, average_cost_with_fees: 110, average_cost_without_fees: 100) }
      # order = Trade.new(unit_type: 'fake', price_per_unit: 125, fee: 5, unit_count: 1)
      # holding = Holding.new(unit_count: 1, average_cost: 100, fees: 1)

      it 'returns true if price is higher' do
        balance = described_class.new(data)
        expect(balance.sell).to eq(true)
      end
    end
  end
end
