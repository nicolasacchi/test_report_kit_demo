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

  def calculate_absorption(pharmacy, product)
    ratio = pharmacy.id.to_f / (product.price_cents + 1)
    ratio > max_absorption ? max_absorption : ratio
  end

  def max_absorption
    0.15
  end

  def apply_discounts(items)
    items.map do |item|
      if item[:price] > 5000
        item.merge(discount: (item[:price] * 0.05).round)
      else
        item
      end
    end
  end

  def validate_availability(pharmacy, products)
    products.all? { |p| p.in_stock? }
  end
end
