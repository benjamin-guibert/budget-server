monthBudgets = V1::MonthBudget.create([{
  id: 1,
  year: 2019,
  month: 1,
  initial_balance: 1623.73
},{
  id: 2,
  year: 2019,
  month: 2,
  initial_balance: 2845.95
},{
  id: 3,
  year: 2019,
  month: 3,
  initial_balance: 4054.20
},{
  id: 4,
  year: 2019,
  month: 5,
  initial_balance: 5878.43
},{
  id: 5,
  year: 2019,
  month: 4,
  initial_balance: 5878.43
},{
  id: 6,
  year: 2018,
  month: 12,
  initial_balance: 0
}])

V1::BudgetRecord.create([{
  id: 1,
  month_budget: monthBudgets[0],
  label: "Income 1",
  record_type: :income,
  date_from: Date.new(2019, 1, 2),
  date_to: Date.new(2019, 1, 31),
  amount: 1234.56,
},{
  id: 2,
  month_budget: monthBudgets[0],
  label: "Expense 1",
  record_type: :expense,
  category: :needs,
  date_from: Date.new(2019, 1, 1),
  date_to: Date.new(2019, 1, 31),
  amount: 12.34
},{
  id: 3,
  month_budget: monthBudgets[1],
  label: "Expense 2",
  record_type: :expense,
  category: :wants,
  date_from: Date.new(2019, 2, 1),
  date_to: Date.new(2019, 2, 28),
  amount: 23.45
},{
  id: 4,
  month_budget: monthBudgets[1],
  label: "Income 2",
  record_type: :income,
  date_from: Date.new(2019, 2, 1),
  date_to: Date.new(2019, 2, 28),
  amount: 1324.12
},{
  id: 5,
  month_budget: monthBudgets[1],
  label: "Expense 3",
  record_type: :expense,
  category: :needs,
  date_from: Date.new(2019, 2, 1),
  date_to: Date.new(2019, 2, 28),
  amount: 92.42
},{
  id: 6,
  month_budget: monthBudgets[2],
  label: "Income 4xx",
  record_type: :income,
  date_from: Date.new(2019, 3, 1),
  date_to: Date.new(2019, 3, 31),
  amount: 1824.23
}])

ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end
