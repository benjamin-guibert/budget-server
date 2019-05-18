class V1::MonthBudget < ApplicationRecord

  # Relations

  has_many :budget_records, -> { order(:date_from) }, dependent: :destroy

  # Finds

  def self.find_by_month(year, month)
    raise ArgumentError.new() unless (year.is_a?(Integer) && month.is_a?(Integer))

    results = where('year = ? AND month = ?', year, month)
    results.first unless results.size != 1
  end

  # Validations

  validates :year, presence: true, numericality: { only_integer: true, greater_than: 0, less_than: 3000 }
  validates :month, presence: true, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 12 },  uniqueness: { scope: :year }
  validates :initial_balance, presence: true, numericality: true

  validate :read_only_fields_cannot_be_updated, on: :update

  validates_associated :budget_records

  private

  def read_only_fields_cannot_be_updated
     errors.add(:year, "cannot be changed") if year_changed?
     errors.add(:month, "cannot be changed") if month_changed?
  end
end
