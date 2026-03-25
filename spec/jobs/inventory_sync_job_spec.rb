require "rails_helper"

RSpec.describe InventorySyncJob, type: :job do
  # Deliberately heavy before hooks
  let(:pharmacy) { create(:pharmacy) }

  before do
    # Simulate heavy setup
    create_list(:product, 5, active: true, stock: 10)
  end

  describe "#perform" do
    it "syncs products for active pharmacy" do
      expect { described_class.perform_now(pharmacy.id) }.not_to raise_error
    end

    it "skips inactive pharmacies" do
      inactive = create(:pharmacy, active: false)
      # Should return early
      expect { described_class.perform_now(inactive.id) }.not_to raise_error
    end
  end
end
