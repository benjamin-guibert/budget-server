monthBudgets = V1::MonthBudget.create([{
  id: 1,
  year: 2019,
  month: 4,
  initial_balance: 1623.73
},{
  id: 2,
  year: 2019,
  month: 5,
  initial_balance: 2437.15
},{
  id: 3,
  year: 2019,
  month: 6,
  initial_balance: 3616.57
},{
  id: 4,
  year: 2019,
  month: 7,
  initial_balance: 4262.98
},{
  id: 5,
  year: 2019,
  month: 8,
  initial_balance: 4262.98
},{
  id: 6,
  year: 2019,
  month: 9,
  initial_balance: 4262.98
},{
  id: 7,
  year: 2019,
  month: 10,
  initial_balance: 4262.98
},{
  id: 8,
  year: 2019,
  month: 11,
  initial_balance: 4262.98
},{
  id: 9,
  year: 2019,
  month: 12,
  initial_balance: 4262.98
}])

V1::BudgetRecord.create([{
  id: 1,
  month_budget: monthBudgets[0],
  label: 'Bill #201904-01',
  record_type: :income,
  date_from: Date.new(2019, 4, 1),
  date_to: Date.new(2019, 4, 30),
  amount: 826.00
},
{
  id: 2,
  month_budget: monthBudgets[0],
  label: "VPN",
  record_type: :expense,
  category: :needs,
  date_from: Date.new(2019, 4, 1),
  date_to: Date.new(2019, 4, 30),
  amount: 3.59
},
{
  id: 3,
  month_budget: monthBudgets[0],
  label: "Mobile phone",
  record_type: :expense,
  category: :needs,
  date_from: Date.new(2019, 4, 1),
  date_to: Date.new(2019, 4, 30),
  amount: 8.99
},
{
  id: 4,
  month_budget: monthBudgets[1],
  label: "Bill #201905-01",
  record_type: :income,
  date_from: Date.new(2019, 5, 1),
  date_to: Date.new(2019, 5, 31),
  amount: 1192.00
},
{
  id: 5,
  month_budget: monthBudgets[1],
  label: "VPN",
  record_type: :expense,
  category: :needs,
  date_from: Date.new(2019, 5, 1),
  date_to: Date.new(2019, 5, 31),
  amount: 3.59
},
{
  id: 6,
  month_budget: monthBudgets[1],
  label: "Mobile phone",
  record_type: :expense,
  category: :needs,
  date_from: Date.new(2019, 5, 1),
  date_to: Date.new(2019, 5, 31),
  amount: 8.99
},
{
  id: 7,
  month_budget: monthBudgets[2],
  label: "Bill #201906-01",
  record_type: :income,
  date_from: Date.new(2019, 6, 1),
  date_to: Date.new(2019, 6, 30),
  amount: 650.00
},
{
  id: 8,
  month_budget: monthBudgets[2],
  label: "VPN",
  record_type: :expense,
  category: :needs,
  date_from: Date.new(2019, 6, 1),
  date_to: Date.new(2019, 6, 30),
  amount: 3.59
}])
