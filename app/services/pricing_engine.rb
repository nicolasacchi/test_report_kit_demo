class PricingEngine
  def initialize(product, pharmacy = nil)
    @product = product
    @pharmacy = pharmacy
  end

  def calculate
    base = @product.price_cents
    { final_price: base, currency: "EUR" }
  end
end
