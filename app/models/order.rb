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

  def cancel!(reason: nil)
    update!(status: "cancelled", notes: reason)
  end

  def cod?
    payment_method == "cod"
  end

  def recalculate_total!
    update!(total_cents: order_items.sum { |item| item.subtotal_cents })
  end

  def awaiting_cod_confirmation?
    cod? && status == "pending"
  end

  def handle_cod_timeout
    return unless payment_method == "cod"
    cancel!(reason: "cod_timeout") if awaiting_cod_confirmation?
    notify_cs_team(:cod_timeout_alert)
  end

  private

  def notify_cs_team(alert_type)
    # placeholder
  end
end
