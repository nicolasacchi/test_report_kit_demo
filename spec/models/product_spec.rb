require "rails_helper"

RSpec.describe Product, type: :model do
  describe "validations" do
    subject { build(:product) }

    it { is_expected.to be_valid }

    it "requires name" do
      subject.name = nil
      expect(subject).not_to be_valid
    end

    it "requires minsan_code" do
      subject.minsan_code = nil
      expect(subject).not_to be_valid
    end

    it "requires unique minsan_code" do
      create(:product, minsan_code: "DUP001")
      subject.minsan_code = "DUP001"
      expect(subject).not_to be_valid
    end

    it "requires positive price" do
      subject.price_cents = -1
      expect(subject).not_to be_valid
    end
  end

  describe "scopes" do
    it ".active returns only active products" do
      active = create(:product, active: true)
      create(:product, active: false)
      expect(Product.active).to eq([active])
    end

    it ".in_stock returns products with stock > 0" do
      in_stock = create(:product, stock: 10)
      create(:product, stock: 0)
      expect(Product.in_stock).to eq([in_stock])
    end

    it ".by_category filters by category" do
      pharma = create(:product, category: "pharma")
      create(:product, category: "cosmetics")
      expect(Product.by_category("pharma")).to eq([pharma])
    end
  end

  describe "#display_price" do
    it "formats price as EUR string" do
      product = build(:product, price_cents: 1299)
      expect(product.display_price).to eq("12.99")
    end
  end

  describe "#in_stock?" do
    it "returns true when stock > 0" do
      expect(build(:product, stock: 5).in_stock?).to be true
    end

    it "returns false when stock is 0" do
      expect(build(:product, stock: 0).in_stock?).to be false
    end
  end

  describe "#reserve!" do
    it "decrements stock" do
      product = create(:product, stock: 10)
      product.reserve!(3)
      expect(product.reload.stock).to eq(7)
    end

    it "raises when insufficient stock" do
      product = create(:product, stock: 2)
      expect { product.reserve!(5) }.to raise_error("Insufficient stock")
    end
  end
end
