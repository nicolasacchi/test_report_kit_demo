require "rails_helper"

RSpec.describe Pharmacy, type: :model do
  describe "validations" do
    subject { build(:pharmacy) }

    it { is_expected.to be_valid }

    it "requires name" do
      subject.name = nil
      expect(subject).not_to be_valid
    end

    it "requires unique code" do
      create(:pharmacy, code: "DUP001")
      subject.code = "DUP001"
      expect(subject).not_to be_valid
    end
  end

  describe "#accepts_orders?" do
    it "returns true when active and auto-accept" do
      pharmacy = build(:pharmacy, active: true, auto_accept_orders: true)
      expect(pharmacy.accepts_orders?).to be true
    end

    it "returns false when inactive" do
      pharmacy = build(:pharmacy, active: false, auto_accept_orders: true)
      expect(pharmacy.accepts_orders?).to be false
    end

    it "returns false when not auto-accept" do
      pharmacy = build(:pharmacy, active: true, auto_accept_orders: false)
      expect(pharmacy.accepts_orders?).to be false
    end
  end
end
