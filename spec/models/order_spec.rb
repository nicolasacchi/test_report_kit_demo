require "rails_helper"

RSpec.describe Order, type: :model do
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
end
