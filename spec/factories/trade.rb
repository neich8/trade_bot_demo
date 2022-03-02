FactoryBot.define do
  factory :trade do
    unit_type { 'fake' }
    price_per_unit { 10 }
    fee { 10 }
    unit_count { 1 }
  end
end
