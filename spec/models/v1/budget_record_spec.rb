require 'rails_helper'


RSpec.describe V1::BudgetRecord, type: :model do
  it { should validate_presence_of(:label) }
  it { should validate_presence_of(:record_type) }
  it { should validate_presence_of(:date_from) }
  it { should validate_presence_of(:date_to) }
  it { should validate_presence_of(:amount) }

  let!(:budget_records) { V1::BudgetRecord.all }

  it "gets all by type" do
    expected = [
      budget_records[1],
      budget_records[2],
      budget_records[4]
    ]

    expect(V1::BudgetRecord.by_type(:expense)).to match_array(expected)
  end

  it "gets all incomes" do
    expected = [
      budget_records[0],
      budget_records[3],
      budget_records[5]
    ]

    expect(V1::BudgetRecord.incomes).to match_array(expected)
  end

  it "gets all expenses" do
    expected = [
      budget_records[1],
      budget_records[2],
      budget_records[4]
    ]

    expect(V1::BudgetRecord.expenses).to match_array(expected)
  end

  it "gets all by date" do
    expected = [
      budget_records[2],
      budget_records[3],
      budget_records[4]
    ]

    expect(V1::BudgetRecord.by_date(Date.new(2019, 2, 1), Date.new(2019, 2, 28))).to match_array(expected)
  end
end
