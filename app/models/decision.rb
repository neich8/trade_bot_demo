class Decision < ApplicationRecord
  belongs_to :decidor_attribute
  belongs_to :trade

  delegate :rules_set, to: :decidor_attribute

  SINGLE_COIN_RULES = [
    Rules::Balance,
    Rules::HighPrice,
    Rules::LowPrice,
    Rules::SellOrBuy,
    Rules::ValidOrderAmount
  ].freeze

  def decide!
    self.buy_result = result(:buy)
    self.sell_result = result(:sell)
    save!
  end

  # if balance is not enough then this will fail if holding
  def purchase?
    rules_set.map { |rule| check(rule, :buy) }.compact.all?
  end

  def sell?
    rules_set.map { |rule| check(rule, :sell) }.compact.all?
  end

  private

  def failed_rule(need)
    rules_set.map { |rule| rule.new(decidor_attribute).send(need.to_sym) }.compact.all?
  end

  def result(action)
    rules_set.map { |rule| { rule.to_s => rule.new(decidor_attribute).send(action.to_sym) } }
  end

  def check(rule, need_decision_for)
    rule.new(decidor_attribute).send(need_decision_for.to_sym)
  end
end
