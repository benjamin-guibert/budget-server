class V1::MonthBudget < ApplicationRecord

  # Relations

  has_many :budget_records, -> { order(:date_from) }

  # Scopes

  scope :by_month, -> (year, month) {
    raise ArgumentError.new() unless (year.is_a?(Integer) && month.is_a?(Integer))

    where('year = ? AND month = ?', year, month)
  }

  # Validations

  validates :year, presence: true, numericality: { only_integer: true, greater_than: 0, less_than: 3000 }
  validates :month, presence: true, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 12 },  uniqueness: { scope: :year }
  validates :initial_balance, presence: true, numericality: true

  validate :read_only_fields_cannot_be_updated, on: :update

  validates_associated :budget_records

  def self.find_by_month(year, month)
    results = self.by_month(year, month)

    results.first unless results.size != 1
  end

  private

  def read_only_fields_cannot_be_updated
     errors.add(:year, "cannot be changed") if year_changed?
     errors.add(:month, "cannot be changed") if month_changed?
  end
end
