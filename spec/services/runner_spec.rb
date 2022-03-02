require 'rails_helper'
# These are kinda the integration tests
# Should probably nuke this class since it does WAY to much
RSpec.describe Runner do
  before do
    allow(Coinbase::Api).to receive(:sell) { nil }
    allow(Coinbase::Api).to receive(:buy) { nil }
  end

  it 'executes a sell trade' do
    allow_any_instance_of(TradeBuilder).to receive(:build) { build(:trade) }

    Runner.trade(available_to_trade: ['fake'])
  end
end
