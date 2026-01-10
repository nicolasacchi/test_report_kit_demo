class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy

  validates :customer_email, presence: true
  validates :status, inclusion: { in: %w[pending confirmed shipped delivered cancelled] }

  scope :pending, -> { where(status: "pending") }
  scope :active, -> { where.not(status: "cancelled") }

  def confirm!
    update!(status: "confirmed")
  end
end
