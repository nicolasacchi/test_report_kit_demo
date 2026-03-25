require "rails_helper"

RSpec.describe ShippingCalculator do
  let(:order) { create(:order, total_cents: 2000) }

  describe "#calculate" do
    it "returns standard shipping cost" do
      result = described_class.new(order).calculate(method: :standard)
      expect(result[:cost]).to eq(499)
      expect(result[:method]).to eq(:standard)
    end

    it "returns express shipping cost" do
      result = described_class.new(order).calculate(method: :express)
      expect(result[:cost]).to eq(999)
      expect(result[:method]).to eq(:express)
    end

    it "returns free shipping for orders above threshold" do
      big_order = create(:order, total_cents: 5000)
      result = described_class.new(big_order).calculate
      expect(result[:cost]).to eq(0)
      expect(result[:method]).to eq(:free)
    end

    it "adds weight surcharge for large orders" do
      small_order = create(:order, total_cents: 2000)
      7.times { create(:order_item, order: small_order, quantity: 1, unit_price_cents: 200) }
      small_order.update_column(:total_cents, 2000) # keep below free threshold
      result = described_class.new(small_order).calculate(method: :standard)
      expect(result[:cost]).to be > 499
    end

    it "raises for unknown shipping method" do
      expect {
        described_class.new(order).calculate(method: :drone)
      }.to raise_error("Unknown shipping method: drone")
    end
  end
end
