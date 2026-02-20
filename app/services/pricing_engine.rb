class PricingEngine
  def initialize(product, pharmacy = nil)
    @product = product
    @pharmacy = pharmacy
  end

  def calculate
    base = @product.price_cents
    base = apply_pharmacy_markup(base) if @pharmacy
    { final_price: base, currency: "EUR" }
  end

  private

  def apply_pharmacy_markup(price)
    markup = @pharmacy.auto_accept_orders? ? 1.05 : 1.10
    (price * markup).round
  end
end
