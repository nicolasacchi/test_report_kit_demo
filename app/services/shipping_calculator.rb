class ShippingCalculator
  STANDARD_RATE = 499 # cents
  EXPRESS_RATE = 999
  FREE_THRESHOLD = 4900 # free shipping above 49 EUR

  def initialize(order)
    @order = order
  end

  def calculate(method: :standard)
    return { cost: 0, method: :free } if qualifies_for_free_shipping?

    cost = case method
    when :standard then calculate_standard
    when :express then calculate_express
    else raise "Unknown shipping method: #{method}"
    end

    { cost: cost, method: method }
  end

  private

  def qualifies_for_free_shipping?
    @order.total_cents.to_i >= FREE_THRESHOLD
  end

  def calculate_standard
    # Simulate API call latency
    sleep(0.01) if ENV["SIMULATE_LATENCY"]
    STANDARD_RATE + weight_surcharge
  end

  def calculate_express
    sleep(0.01) if ENV["SIMULATE_LATENCY"]
    EXPRESS_RATE + weight_surcharge
  end

  def weight_surcharge
    item_count = @order.order_items.count
    item_count > 5 ? (item_count - 5) * 100 : 0
  end
end
