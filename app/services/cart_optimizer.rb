class CartOptimizer
  class CartOptimizationError < StandardError; end

  def initialize(products, pharmacies)
    @products = products
    @pharmacies = pharmacies
  end

  def optimize
    available = @pharmacies.select(&:accepts_orders?)
    raise CartOptimizationError, "no pharmacies available" if available.empty?

    best = available.min_by { |pharmacy| total_cost(pharmacy) }
    { pharmacy: best, total_cost: total_cost(best), items: build_items(best) }
  end

  private

  def total_cost(pharmacy)
    @products.sum { |p| p.price_cents }
  end

  def build_items(pharmacy)
    @products.map do |product|
      { product: product, pharmacy: pharmacy, price: product.price_cents }
    end
  end
end
