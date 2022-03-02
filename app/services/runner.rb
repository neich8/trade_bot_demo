class Runner
  def self.trade(available_to_trade: [:ethereum])
    # if no funds then sleep this cycle
    # NEED TO handle this when hooked up to tickers/order status

    available_to_trade.each do |coin|
      order = TradeBuilder.new(coin).build
      holding = Holding.find_or_create_by(unit_type: coin)

      decision = DecisionBuilder.new(current_holding: holding, trade: order).build!
      decision.decide!

      if decision.purchase?
        order.trade_type = :buy
      elsif decision.sell?
        order.trade_type = :sell
      end
      order.complete
    end
  end
end
