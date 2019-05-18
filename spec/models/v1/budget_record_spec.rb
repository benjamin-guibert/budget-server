require 'rails_helper'


RSpec.describe V1::BudgetRecord, type: :model do
  let!(:budget_records) { described_class.all }

  describe 'get budget records by type' do
    let!(:category_type) { :expense }
    before { @budget_records = described_class.by_type(category_type) }

    context 'when type is valid' do
      it 'returns budget records' do
        expected_budget_records = [
          budget_records[1],
          budget_records[2],
          budget_records[4]
        ]

        expect(@budget_records).to match_array(expected_budget_records)
      end
    end

    context 'when type does not exist' do
      let(:category_type) { 999 }

      it 'returns nothing' do
        expected_budget_records = []

        expect(@budget_records).to match_array(expected_budget_records)
      end
    end
  end

  describe 'get income records' do
    it 'returns records' do
      expected_budget_records = [
        budget_records[0],
        budget_records[3],
        budget_records[5]
      ]

      expect(described_class.incomes).to match_array(expected_budget_records)
    end
  end

  describe 'get expense records' do
    it 'returns records' do
      expected_budget_records = [
        budget_records[1],
        budget_records[2],
        budget_records[4]
      ]

      expect(described_class.expenses).to match_array(expected_budget_records)
    end
  end

  describe 'get budget records by date' do
    let!(:dates) {{ from: Date.new(2019, 2, 1), to: Date.new(2019, 2, 28) }}
    before { @budget_records = described_class.by_date(dates[:from], dates[:to]) }

    context 'when date is valid' do
      it 'returns records' do
        expected_budget_records = [
          budget_records[2],
          budget_records[3],
          budget_records[4]
        ]

        expect(@budget_records).to match_array(expected_budget_records)
      end
    end

    context 'when a parameter is null' do
      let!(:dates) {{ from: nil, to: Date.new(2019, 2, 28) }}

      it 'returns nothing' do
        expected_budget_records = []

        expect(@budget_records).to match_array(expected_budget_records)
      end
    end

    context 'when date is invalid' do
      let!(:dates) {{ from: Date.new(2019, 2, 28), to: Date.new(2019, 2, 1) }}

      it 'returns nothing' do
        expected_budget_records = []

        expect(@budget_records).to match_array(expected_budget_records)
      end
    end
  end

  describe 'validate a budget record' do
    subject { described_class.new({
      month_budget_id: 2,
      label: 'Label create',
      record_type: :expense,
      category: :wants,
      date_from: Date.new(2019, 5, 1),
      date_to: Date.new(2019, 5, 31),
      amount: 34.56
    })}

    it 'is valid' do
        expect(subject).to be_valid
    end

    it 'is invalid when budget ID is missing' do
      subject.month_budget_id = nil

      expect(subject).to be_invalid
    end

    it 'is invalid when budget ID is invalid' do
      subject.month_budget_id = 999

      expect(subject).to be_invalid
    end

    it 'is invalid when label is missing' do
      subject.label = ''

      expect(subject).to be_invalid
    end

    it 'is invalid when type is missing' do
      subject.record_type = nil

      expect(subject).to be_invalid
    end

    it 'is invalid when type is invalid' do
      subject.record_type = :unknown_type

      expect(subject).to be_invalid
    end

    it 'is valid when type is income and category is null' do
      subject.record_type = :income
      subject.category = nil

      expect(subject).to be_valid
    end

    it 'is invalid when type is income and category is not null' do
      subject.record_type = :income
      subject.category = :needs

      expect(subject).to be_invalid
    end

    it 'is valid when type is expense and category is not null' do
      subject.record_type = :expense
      subject.category = :needs

      expect(subject).to be_valid

      subject.category = :wants

      expect(subject).to be_valid
    end

    it 'is invalid when type is expense and category is null' do
      subject.record_type = :expense
      subject.category = nil

      expect(subject).to be_invalid
    end

    it 'is invalid when type is expense and category is invalid' do
      subject.record_type = :expense
      subject.category = :unknown_category

      expect(subject).to be_invalid
    end

    it 'is invalid when date from is null' do
      subject.date_from = nil

      expect(subject).to be_invalid
    end

    it 'is invalid when date from is invalid' do
      subject.date_from = 'test'

      expect(subject).to be_invalid
    end

    it 'is invalid when date to is null' do
      subject.date_to = nil

      expect(subject).to be_invalid
    end

    it 'is invalid when date to is invalid' do
      subject.date_to = 'test'

      expect(subject).to be_invalid
    end

    it 'is invalid when date to is less than date from' do
      subject.date_from = Date.new(2019, 5, 31)
      subject.date_to = Date.new(2019, 5, 1)

      expect(subject).to be_invalid
    end

    it 'is invalid when amount is null' do
      subject.amount = nil

      expect(subject).to be_invalid
    end

    it 'is invalid when amount is invalid' do
      subject.amount = 'test'

      expect(subject).to be_invalid
    end

    it 'is invalid when amount is 0' do
      subject.amount = 0

      expect(subject).to be_invalid
    end

    it 'is invalid when amount is 1000000' do
      subject.amount = 1000000

      expect(subject).to be_invalid
    end

    it 'is invalid when type is changed on update' do
      subject.save!
      subject.record_type = :income
      subject.category = nil

      expect(subject).to be_invalid
    end

    it 'is invalid when budget ID is changed on update' do
      subject.save!
      subject.month_budget_id = 1

      expect(subject).to be_invalid
    end
  end

  describe 'destroy a budget record' do
    subject { described_class.find(1) }

    it 'destroys the budget record but not the month budget' do
      subject.destroy!

      expect { subject.reload }.to raise_error(ActiveRecord::RecordNotFound)
      expect(V1::MonthBudget.find(1)).to be
    end
  end
end
