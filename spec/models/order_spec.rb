require "rails_helper"

RSpec.describe Order, type: :model do
  # Deliberately heavy factory usage
  describe "validations" do
    it "requires customer_email" do
      order = build(:order, customer_email: nil)
      expect(order).not_to be_valid
    end

    it "validates status inclusion" do
      order = build(:order, status: "invalid")
      expect(order).not_to be_valid
    end
  end

  describe "#confirm!" do
    it "sets status to confirmed" do
      order = create(:order, status: "pending")
      order.confirm!
      expect(order.reload.status).to eq("confirmed")
    end
  end

  describe "#ship!" do
    it "ships confirmed orders" do
      order = create(:order, :confirmed)
      order.ship!
      expect(order.reload.status).to eq("shipped")
      expect(order.shipped_at).to be_present
    end

    it "raises on non-confirmed orders" do
      order = create(:order, status: "pending")
      expect { order.ship! }.to raise_error("Cannot ship unconfirmed order")
    end
  end

  describe "#deliver!" do
    it "delivers shipped orders" do
      order = create(:order, :shipped)
      order.deliver!
      expect(order.reload.status).to eq("delivered")
    end
  end

  describe "#cancel!" do
    it "sets cancelled_at timestamp" do
      order = create(:order, status: "pending")
      order.cancel!(reason: "customer request")
      # BUG: cancelled_at is not set by cancel! — it only sets notes
      expect(order.reload.cancelled_at).to be_present
    end
  end

  describe "#recalculate_total!" do
    it "sums order item subtotals" do
      order = create(:order)
      create(:order_item, order: order, quantity: 2, unit_price_cents: 1000)
      create(:order_item, order: order, quantity: 1, unit_price_cents: 500)
      order.reload.recalculate_total!
      expect(order.total_cents).to eq(2500)
    end
  end
end
