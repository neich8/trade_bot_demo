require 'rails_helper'

RSpec.describe Rules::LowPrice do
  context 'sell' do
    # it 'returns false if price is lower' do
    #   holding = Holding.new(unit_unit_count: 1, average_cost_in_thousandths_of_cents: 100, fees_paid_thousandths_of_cents: 1)
    #   order = Trade.new('fake', total_price: 111, fees: 10)
    #   balance = described_class.new(holding, order)
    #   expect(balance.sell).to eq(false)
    # end

    # it 'returns true if price is higher' do
    #   holding = Holding.new(unit_unit_count: 1, average_cost_in_thousandths_of_cents: 100, fees_paid_thousandths_of_cents: 1)
    #   order = Order.new('fake', total_price: 125, fees: 5)
    #
    #   balance = described_class.new(holding, order)
    #   expect(balance.sell).to eq(true)
    # end
  end

  context 'buy' do
    let(:trade) { build(:trade, unit_type: 'fake', price_per_unit: 111, fee: 10, unit_count: 1) }
    let(:data) { build(:decidor_attribute, trade: trade) }
    it 'returns true if no last trade' do
      balance = described_class.new(data)
      expect(balance.buy).to eq(true)
    end
    it 'returns true if last order is lower' do
      allow(data).to receive(:last_trade) { Trade.new(price_per_unit: 100, unit_count: 1) }
      balance = described_class.new(data)
      expect(balance.buy).to eq(true)
    end

    it 'returns true if last order is lower and 2 hours have passed' do
      last_trade = Trade.new(price_per_unit: 126, unit_count: 1, fee: 0)
      allow(last_trade).to receive(:created_at) { 2.hours.ago }
      allow(data).to receive(:last_trade) { last_trade }
      balance = described_class.new(data)
      expect(balance.buy).to eq(true)
    end

    it 'returns false if last order is higher' do
      last_trade = Trade.new(price_per_unit: 126, unit_count: 1, fee: 0)
      allow(last_trade).to receive(:created_at) { 1.hours.ago }
      allow(data).to receive(:last_trade) { last_trade }
      balance = described_class.new(data)
      expect(balance.buy).to eq(false)
    end
  end
end
