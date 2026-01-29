require "rails_helper"

RSpec.describe OrderItem, type: :model do
  describe "#subtotal_cents" do
    it "multiplies quantity by unit price" do
      # Deliberately using create (heavy factory usage)
      item = create(:order_item, quantity: 3, unit_price_cents: 1500)
      expect(item.subtotal_cents).to eq(4500)
    end
  end

  describe "callback" do
    it "recalculates order total on save" do
      order = create(:order)
      create(:order_item, order: order, quantity: 2, unit_price_cents: 1000)
      expect(order.reload.total_cents).to eq(2000)
    end
  end
end
