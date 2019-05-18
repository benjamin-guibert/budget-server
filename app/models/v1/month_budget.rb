class V1::MonthBudget < ApplicationRecord

  # Enumerations

  enum month: {
    january: 1,
    february: 2,
    march: 3,
    april: 4,
    may: 5,
    june: 6,
    july: 7,
    august: 8,
    september: 9,
    october: 10,
    november: 11,
    december: 12
  }

  # Relations

  has_many :budget_records, -> { order(:date_from) }, dependent: :destroy

  # Scopes

  scope :ordered_by_date, -> { order(year: :asc, month: :asc) }

  # Finds

  def self.find_by_month(year, month)
    find_by!(year: year, month: month)
  end

  # Validations

  validates :year, presence: true, numericality: { only_integer: true, greater_than: 0, less_than: 3000 }
  validates :month, presence: true, inclusion: %w(january february march april may june july august september october november december),  uniqueness: { scope: :year }
  validates :initial_balance, presence: true, numericality: true

  validate :read_only_fields_cannot_be_updated, on: :update

  validates_associated :budget_records

  private

  def read_only_fields_cannot_be_updated
     errors.add(:year, "cannot be changed") if year_changed?
     errors.add(:month, "cannot be changed") if month_changed?
  end
end
