class DecisionBuilder
  attr_reader :rules_set, :trade, :current_holding

  def initialize(current_holding:, trade:, rules_set: nil)
    @current_holding = current_holding
    @trade = trade
    @rules_set = rules_set || Decision::SINGLE_COIN_RULES
  end

  def build!
    data = DecidorAttribute.create(trade: trade,
                                   average_cost_with_fees: current_holding.average_cost(with_fees: true),
                                   average_cost_without_fees: current_holding.average_cost(with_fees: false),
                                   usd_balance: Holding.usd.unit_count,
                                   current_unit_count: current_holding.unit_count,
                                   rules_checked: rules_set)
    Decision.create(decidor_attribute: data, trade: trade)
  end
end
