class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :unit_price_cents, presence: true, numericality: { greater_than: 0 }

  after_save :recalculate_order_total

  def subtotal_cents
    quantity * unit_price_cents
  end

  private

  def recalculate_order_total
    order.recalculate_total!
  end
end
