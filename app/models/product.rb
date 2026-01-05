class Product < ApplicationRecord
  validates :name, presence: true
  validates :minsan_code, presence: true, uniqueness: true
  validates :price_cents, presence: true, numericality: { greater_than: 0 }
  validates :stock, numericality: { greater_than_or_equal_to: 0 }

  scope :active, -> { where(active: true) }
  scope :in_stock, -> { where("stock > 0") }
  scope :by_category, ->(cat) { where(category: cat) }

  def display_price
    format("%.2f", price_cents / 100.0)
  end

  def in_stock?
    stock.to_i > 0
  end

  def reserve!(quantity)
    raise "Insufficient stock" if stock < quantity
    update!(stock: stock - quantity)
  end
end
