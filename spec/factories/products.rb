FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "Product #{n}" }
    sequence(:minsan_code) { |n| "MINSAN#{n.to_s.rjust(6, '0')}" }
    price_cents { rand(500..15000) }
    stock { rand(0..200) }
    category { %w[pharma otc cosmetics supplements].sample }
    active { true }
  end
end
