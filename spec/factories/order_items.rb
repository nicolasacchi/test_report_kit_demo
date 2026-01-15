FactoryBot.define do
  factory :order_item do
    order
    product
    quantity { rand(1..5) }
    unit_price_cents { product.price_cents }
  end
end
