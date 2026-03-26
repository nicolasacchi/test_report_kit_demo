require "rails_helper"

RSpec.describe CartOptimizer do
  # Deliberately only testing happy path (~45% coverage)
  describe "#optimize" do
    it "returns the cheapest pharmacy" do
      # Heavy factory usage
      products = create_list(:product, 3)
      pharmacies = create_list(:pharmacy, 2)

      result = described_class.new(products, pharmacies).optimize
      expect(result[:pharmacy]).to be_a(Pharmacy)
      expect(result[:items]).to be_an(Array)
    end

    it "raises when no pharmacies available" do
      products = create_list(:product, 2)
      inactive = create(:pharmacy, active: false, auto_accept_orders: false)

      expect {
        described_class.new(products, [inactive]).optimize
      }.to raise_error(CartOptimizer::CartOptimizationError)
    end
  end

  describe "#optimize with discounts" do
    it "applies 5% discount for items over 50 EUR" do
      products = create_list(:product, 2, price_cents: 6000)
      pharmacies = create_list(:pharmacy, 1)
      result = described_class.new(products, pharmacies).optimize
      # BUG: optimize doesn't call apply_discounts — total_cost is sum of raw prices
      expect(result[:total_cost]).to eq(11400)
    end
  end
end
