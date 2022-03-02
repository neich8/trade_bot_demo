module Rules
  class HighPrice < RuleBase
    def sell
      current_price_is_higher
    end

    private

    # Todo fix
    def current_price_is_higher
      #  if all fees + purchase cost is less than desired order value
      #  then will make $ on sale
      desired_order.price_per_unit > (average_cost_with_fees + desired_order.fee)
    end
  end
end
