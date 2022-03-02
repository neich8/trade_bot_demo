module Rules
  class RuleBase
    # TODO: use delegate!
    attr_reader :holdings,
                :desired_order,
                :average_cost_with_fees,
                :average_cost_without_fees,
                :usd_balance,
                :current_unit_count,
                :last_trade

    def initialize(data)
      @desired_order = data.trade
      @average_cost_with_fees = data.average_cost_with_fees
      @average_cost_without_fees = data.average_cost_without_fees
      @usd_balance = data.usd_balance
      @current_unit_count = data.current_unit_count
      @last_trade = data.last_trade
    end

    def sell
      true
    end

    def hold
      true
    end

    def buy
      true
    end
  end
end
