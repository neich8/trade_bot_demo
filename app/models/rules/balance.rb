require_relative 'rule_base'

module Rules
  class Balance < RuleBase
    # TODO: need to add a guard against pulling in more funds
    def buy
      return false if usd_balance.zero?

      usd_balance > desired_order.total_price
    end
  end
end
