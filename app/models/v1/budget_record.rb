class V1::BudgetRecord < ApplicationRecord
  enum record_type: {
    unknown_type: 0,
    income: 1,
    expense: 2
  }
  enum category: {
    unknown_category: 0,
    needs: 1,
    wants: 2
  }

  scope :by_type, -> record_type { where record_type: record_type}
  scope :incomes, -> { by_type(:income)}
  scope :expenses, -> { by_type(:expense)}
  scope :by_date, -> date_from, date_to { where('date_from < ? AND date_to > ?', date_to, date_from) }

  validates_presence_of :label, :record_type, :date_from, :date_to, :amount
end
