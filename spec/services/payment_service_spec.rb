require "rails_helper"

RSpec.describe PaymentService do
  describe "#authorize!" do
    it "authorizes a valid order" do
      order = create(:order, total_cents: 5000)
      result = described_class.new(order).authorize!
      expect(result[:status]).to eq(:authorized)
    end

    it "raises for already confirmed orders" do
      order = create(:order, :confirmed, total_cents: 5000)
      expect { described_class.new(order).authorize! }.to raise_error(PaymentService::PaymentError)
    end
  end

  describe "#capture!" do
    it "captures confirmed orders" do
      order = create(:order, :confirmed, total_cents: 5000)
      result = described_class.new(order).capture!
      expect(result[:status]).to eq(:captured)
    end
  end

  describe "#refund!" do
    it "includes a refund transaction ID" do
      order = create(:order, :confirmed, total_cents: 5000)
      result = described_class.new(order).refund!
      # BUG: refund! returns {status: :refunded, amount: X} but no :transaction_id
      expect(result[:transaction_id]).to be_present
    end
  end
end
