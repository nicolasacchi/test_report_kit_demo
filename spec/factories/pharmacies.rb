FactoryBot.define do
  factory :pharmacy do
    sequence(:name) { |n| "Pharmacy #{n}" }
    sequence(:code) { |n| "PH#{n.to_s.rjust(4, '0')}" }
    active { true }
    auto_accept_orders { true }
  end
end
