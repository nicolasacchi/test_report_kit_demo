FactoryBot.define do
  factory :order do
    sequence(:customer_email) { |n| "customer#{n}@example.com" }
    status { "pending" }
    total_cents { 0 }
    payment_method { "card" }

    trait :with_items do
      after(:create) do |order|
        pharmacy = create(:pharmacy)
        3.times do
          product = create(:product)
          create(:order_item, order: order, product: product, unit_price_cents: product.price_cents)
        end
      end
    end

    trait :confirmed do
      status { "confirmed" }
    end

    trait :shipped do
      status { "shipped" }
      shipped_at { Time.current }
    end

    trait :cod do
      payment_method { "cod" }
    end
  end
end
