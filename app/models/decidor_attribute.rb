class DecidorAttribute < ApplicationRecord
  belongs_to :trade
  has_one :decision

  def rules_set
    rules_checked.map(&:constantize)
  end

  def last_trade
    Trade.where.not(id: trade.id).where(unit_type: trade.unit_type, committed: true).order(created_at: :desc).first
  end
end
