class V1::BudgetRecord < ApplicationRecord
  scope :by_type, -> record_type { where record_type: record_type}
  scope :incomes, -> { by_type(1)}
  scope :expenses, -> { by_type(2)}
  scope :by_date, -> date_from, date_to { where('date_from < ? AND date_to > ?', date_to, date_from) }

  validates_presence_of :label, :record_type, :date_from, :date_to, :amount
end
