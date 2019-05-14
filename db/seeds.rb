# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

BudgetRecord.create([{
  id: 1,
  label: 'Starting income',
  record_type: 0,
  date_from: Date.new(2019, 4, 1),
  date_to: Date.new(2019, 4, 30),
  amount: 2345.67
},
{
  id: 2,
  label: "VPN",
  record_type: 1,
  category: 0,
  date_from: Date.new(2019, 4, 1),
  date_to: Date.new(2019, 4, 30),
  amount: 3.59
},
{
  id: 3,
  label: "Mobile phone",
  record_type: 1,
  category: 0,
  date_from: Date.new(2019, 4, 1),
  date_to: Date.new(2019, 4, 30),
  amount: 8.99
},
{
  id: 4,
  label: "Starting income",
  record_type: 0,
  date_from: Date.new(2019, 5, 1),
  date_to: Date.new(2019, 5, 31),
  amount: 2333.09
},
{
  id: 5,
  label: "VPN",
  record_type: 1,
  category: 0,
  date_from: Date.new(2019, 5, 1),
  date_to: Date.new(2019, 5, 31),
  amount: 3.59
},
{
  id: 6,
  label: "Mobile phone",
  record_type: 1,
  category: 0,
  date_from: Date.new(2019, 5, 1),
  date_to: Date.new(2019, 5, 31),
  amount: 8.99
},
{
  id: 7,
  label: "Starting income",
  record_type: 0,
  date_from: Date.new(2019, 6, 1),
  date_to: Date.new(2019, 6, 30),
  amount: 2320.51
},
{
  id: 8,
  label: "VPN",
  record_type: 1,
  category: 0,
  date_from: Date.new(2019, 6, 1),
  date_to: Date.new(2019, 6, 30),
  amount: 3.59
},
{
  id: 9,
  label: "Starting income",
  record_type: 0,
  date_from: Date.new(2019, 7, 1),
  date_to: Date.new(2019, 7, 31),
  amount: 2316.92
},
{
  id: 10,
  label: "Starting income",
  record_type: 0,
  date_from: Date.new(2019, 8, 1),
  date_to: Date.new(2019, 8, 31),
  amount: 2316.92
},
{
  id: 11,
  label: "Starting income",
  record_type: 0,
  date_from: Date.new(2019, 9, 1),
  date_to: Date.new(2019, 9, 30),
  amount: 2316.92
},
{
  id: 12,
  label: "Starting income",
  record_type: 0,
  date_from: Date.new(2019, 10, 1),
  date_to: Date.new(2019, 10, 31),
  amount: 2316.92
},
{
  id: 13,
  label: "Starting income",
  record_type: 0,
  date_from: Date.new(2019, 11, 1),
  date_to: Date.new(2019, 11, 30),
  amount: 2316.92
}])
