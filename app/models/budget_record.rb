class BudgetRecord < ApplicationRecord
  validates_presence_of :label, :record_type, :date_from, :date_to, :amount
end
