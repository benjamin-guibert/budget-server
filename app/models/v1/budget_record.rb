class V1::BudgetRecord < ApplicationRecord
  scope :by_record_type, -> record_type { where record_type: record_type}

  validates_presence_of :label, :record_type, :date_from, :date_to, :amount
end
