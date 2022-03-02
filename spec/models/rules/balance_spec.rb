require 'rails_helper'

RSpec.describe Rules::Balance do
  let(:data) { build(:decidor_attribute, usd_balance: 1) }
  context 'buy' do
    it 'returns false if order greater than available balance' do
      balance = described_class.new(data)
      expect(balance.buy).to eq(false)
    end

    it 'returns true if order less than available balance' do
      data.usd_balance = 21
      balance = described_class.new(data)
      expect(balance.buy).to eq(true)
    end
  end
end
