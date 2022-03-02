FactoryBot.define do
  factory :decidor_attribute do
    average_cost_with_fees { 10 }
    average_cost_without_fees {}
    usd_balance {}
    current_unit_count {}
    rules_checked {}
    trade { build(:trade) }
  end
end
