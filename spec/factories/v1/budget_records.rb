V1::BudgetRecord.create([{
  id: 1,
  label: "Income 1",
  record_type: :income,
  date_from: Date.new(2019, 1, 1),
  date_to: Date.new(2019, 1, 31),
  amount: 1234.56
}, {
  id: 2,
  label: "Expense 1",
  record_type: :expense,
  category: :needs,
  date_from: Date.new(2019, 1, 1),
  date_to: Date.new(2019, 1, 15),
  amount: 12.34
}, {
  id: 3,
  label: "Expense 2",
  record_type: :expense,
  category: :wants,
  date_from: Date.new(2019, 1, 15),
  date_to: Date.new(2019, 2, 15),
  amount: 23.45
}, {
  id: 4,
  label: "Income 2",
  record_type: :income,
  date_from: Date.new(2019, 2, 1),
  date_to: Date.new(2019, 2, 28),
  amount: 1324.12
}, {
  id: 5,
  label: "Expense 3",
  record_type: :expense,
  category: :needs,
  date_from: Date.new(2019, 2, 15),
  date_to: Date.new(2019, 3, 15),
  amount: 92.42
}, {
  id: 6,
  label: "Income 4",
  record_type: :income,
  date_from: Date.new(2019, 3, 1),
  date_to: Date.new(2019, 3, 31),
  amount: 1824.23
}])
