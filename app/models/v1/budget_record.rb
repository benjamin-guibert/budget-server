class V1::BudgetRecord < ApplicationRecord

  # Enumerations

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

  # Relations

  belongs_to :month_budget

  # Scopes

  scope :by_type, -> record_type { where record_type: record_type}
  scope :incomes, -> { by_type(:income) }
  scope :expenses, -> { by_type(:expense) }
  scope :by_date, -> date_from, date_to { where('date_from < ? AND date_to > ?', date_to, date_from) }

  # Validations

  validates :month_budget, presence: true
  validates :label, presence: true
  validates :record_type, presence: true, inclusion: %w(income expense)
  validates :category, presence: { message: 'must be defined for expenses'}, inclusion: { in: %w(needs wants)}, if: :expense?
  validates :category, absence: { message: 'cannot be defined for incomes'}, if: :income?
  validates :date_from, presence: true
  validates :date_to, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0, less_than: 1000000}

  validate :date_to_must_be_greater_than_or_equal_to_date_from

  validate :read_only_fields_cannot_be_updated, on: :update

  private

  def read_only_fields_cannot_be_updated
     errors.add(:month_budget, "cannot be changed") if month_budget_id_changed?
     errors.add(:record_type, "cannot be changed") if record_type_changed?
  end

  def date_to_must_be_greater_than_or_equal_to_date_from
    if (date_from.present? && date_to.present? && date_to < date_from)
      errors.add(:date_to, "must be greater than or equal to date from")
    end
  end
end
