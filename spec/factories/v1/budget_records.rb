FactoryBot.define do
  factory :budget_record_v1, :class => V1::BudgetRecord do
    label { Faker::Lorem.word }
    record_type { 1 }
    category { Faker::Number.between(1, 3)}
    date_from { Date.new(2019, 1, 1)}
    date_to { Date.new(2019, 1, 31)}
    amount { Faker::Number.decimal(2) }
  end
end
