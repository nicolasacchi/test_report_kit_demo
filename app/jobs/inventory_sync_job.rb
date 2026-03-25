class InventorySyncJob < ApplicationJob
  queue_as :default

  def perform(pharmacy_id)
    pharmacy = Pharmacy.find(pharmacy_id)
    return unless pharmacy.active?

    products = Product.active.in_stock
    products.each do |product|
      sync_product(pharmacy, product)
    end
  end

  private

  def sync_product(pharmacy, product)
    # Simulate external API sync
    { pharmacy: pharmacy.code, product: product.minsan_code, stock: product.stock }
  end
end
