create_table 'decidor_attributes', force: :cascade do |t|
  t.decimal 'average_cost_with_fees', precision: 15, scale: 10, default: '0.0', null: false
  t.decimal 'average_cost_without_fees', precision: 15, scale: 10, default: '0.0', null: false
  t.decimal 'usd_balance', precision: 15, scale: 10, default: '0.0', null: false
  t.decimal 'current_unit_count', precision: 15, scale: 10, default: '0.0', null: false
  t.string 'rules_checked', array: true
  t.bigint 'trade_id'
  t.datetime 'created_at', precision: 6, null: false
  t.datetime 'updated_at', precision: 6, null: false
  t.index ['trade_id'], name: 'index_decidor_attributes_on_trade_id'
end

create_table 'decisions', force: :cascade do |t|
  t.jsonb 'buy_result'
  t.jsonb 'sell_result'
  t.bigint 'trade_id'
  t.bigint 'decidor_attribute_id'
  t.datetime 'created_at', precision: 6, null: false
  t.datetime 'updated_at', precision: 6, null: false
  t.index ['decidor_attribute_id'], name: 'index_decisions_on_decidor_attribute_id'
  t.index ['trade_id'], name: 'index_decisions_on_trade_id'
end
