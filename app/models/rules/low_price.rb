module Rules
  class LowPrice < RuleBase
    def buy
      # if no purchase history then buy
      return true if last_trade.nil?

      # may need some help if price never goes down then will never buy?
      # maybe simple if x amount of time then buy? 2 hours to start
      last_trade.price_per_unit < (desired_order.price_per_unit / desired_order.unit_count) || (last_trade.created_at < 2.hours.ago)
    end

    # if price is down > 35% then get out
    def sell
      current_holdings_in_usd = average_cost_with_fees
      if current_holdings_in_usd < desired_order.total_price
        (current_holdings_in_usd / (current_holdings_in_usd - desired_order.total_price).abs).to_f > 0.35
      end
    end
  end
end
