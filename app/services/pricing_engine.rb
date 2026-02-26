class PricingEngine
  def initialize(product, pharmacy = nil)
    @product = product
    @pharmacy = pharmacy
  end

  def calculate
    base = @product.price_cents
    base = apply_pharmacy_markup(base) if @pharmacy
    base = apply_volume_discount(base)
    base = apply_seasonal_adjustment(base)
    { final_price: base, currency: "EUR" }
  end

  private

  def apply_pharmacy_markup(price)
    markup = @pharmacy.auto_accept_orders? ? 1.05 : 1.10
    (price * markup).round
  end

  def apply_volume_discount(price)
    return price if @product.stock.to_i < 100
    (price * 0.97).round
  end

  def apply_seasonal_adjustment(price)
    month = Time.current.month
    if [11, 12, 1].include?(month)
      (price * 1.08).round # winter markup
    elsif [6, 7, 8].include?(month)
      (price * 0.95).round # summer discount
    else
      price
    end
  end
end
