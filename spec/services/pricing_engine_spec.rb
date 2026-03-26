require "rails_helper"

RSpec.describe PricingEngine do
  describe "#calculate" do
    it "does not apply volume discount for low stock" do
      product = create(:product, price_cents: 1000, stock: 200)
      result = described_class.new(product).calculate
      # BUG: stock is 200 (>= 100) so volume discount IS applied (0.96x)
      # This expects no discount, but the engine applies 4% off
      expect(result[:final_price]).to eq(1000)
    end
  end
end
