class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy

  validates :customer_email, presence: true
  validates :status, inclusion: { in: %w[pending confirmed shipped delivered cancelled] }

  scope :pending, -> { where(status: "pending") }
  scope :active, -> { where.not(status: "cancelled") }

  def confirm!
    update!(status: "confirmed")
  end

  def ship!
    raise "Cannot ship unconfirmed order" unless status == "confirmed"
    update!(status: "shipped", shipped_at: Time.current)
  end

  def deliver!
    raise "Cannot deliver unshipped order" unless status == "shipped"
    update!(status: "delivered")
  end
end
