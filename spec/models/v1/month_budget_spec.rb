require 'rails_helper'

RSpec.describe V1::MonthBudget, type: :model do
  let!(:month_budgets) { described_class.all }

  describe 'get month budgets with records ordered by date from' do
    it 'returns month budgets' do
      month_budget = described_class.find(1)
      budget_records = V1::BudgetRecord.where(month_budget_id: 1)

      expected_budget_records = [
        budget_records[1],
        budget_records[0]
      ]

      expect(month_budget.budget_records).to match_array(expected_budget_records)
    end
  end

  describe 'get month budgets ordered by date' do
    before { @month_budgets = described_class.ordered_by_date() }

    it 'returns month budgets' do
      expected_month_budgets = [
        month_budgets[5],
        month_budgets[0],
        month_budgets[1],
        month_budgets[2],
        month_budgets[4],
        month_budgets[3]
      ]

      expect(@month_budgets).to match_array(expected_month_budgets)
    end
  end

  describe 'find a month budget by month' do
    let(:year) { 2019 }
    let(:month) { 2 }

    before do
      begin
        @month_budget = described_class.find_by_month(year, month)
      rescue ArgumentError => e
        @error = e
      end
    end

    context 'when parameters are valid' do
      it 'returns a month budget' do
        expect(@month_budget).to be
        expect(@month_budget.id).to eq(2)
        expect(@error).to be_nil
      end
    end

    context 'when year is invalid' do
      let(:year) { 'test' }

      it 'throw an exception' do
        expect(@month_budget).to be_nil
        expect(@error).to be_a(ArgumentError)
      end
    end

    context 'when year is unknown' do
      let(:year) { 2010 }

      it 'returns nothing' do
        expect(@month_budget).to be_nil
        expect(@error).to be_nil
      end
    end

    context 'when month is invalid' do
      let(:month) { 'test' }

      it 'throw an exception' do
        expect(@month_budget).to be_nil
        expect(@error).to be_a(ArgumentError)
      end
    end

    context 'when month is unknown' do
      let(:month) { 12 }

      it 'returns nothing' do
        expect(@month_budget).to be_nil
        expect(@error).to be_nil
      end
    end
  end

  describe 'validate a month budget' do
    subject { described_class.new({
      year: 2019,
      month: 6,
      initial_balance: 1234.56
    })}

    it 'is valid' do
      expect(subject).to be_valid
    end

    it 'is invalid when year is null' do
      subject.year = nil

      expect(subject).to be_invalid
    end

    it 'is invalid when year is invalid' do
      subject.year = 0

      expect(subject).to be_invalid

      subject.year = 3000

      expect(subject).to be_invalid
    end

    it 'is invalid when month is null' do
      subject.month = nil

      expect(subject).to be_invalid
    end

    it 'is invalid when month is invalid' do
      subject.month = 0

      expect(subject).to be_invalid

      subject.month = 13

      expect(subject).to be_invalid
    end

    it 'is invalid when month already exists' do
      subject.month = 1

      expect(subject).to be_invalid
    end

    it 'is invalid when initial balance is null' do
      subject.initial_balance = nil

      expect(subject).to be_invalid
    end

    it 'is invalid when a record in invalid' do
      subject.budget_records.push(V1::BudgetRecord.new({
        label: 'Label'
      }))

      expect(subject).to be_invalid
    end

    it 'is invalid when year is changed on update' do
      subject.save!
      subject.year = 2020

      expect(subject).to be_invalid
    end

    it 'is invalid when month is changed on update' do
      subject.save!
      subject.month = 7

      expect(subject).to be_invalid
    end
  end

  describe 'destroy a month budget' do
    subject { described_class.find(1) }
    it 'destroys the month budget and its records' do
      subject.destroy!

      expect { subject.reload }.to raise_error(ActiveRecord::RecordNotFound)
      expect { V1::BudgetRecord.find(1) }.to raise_error(ActiveRecord::RecordNotFound)
      expect { V1::BudgetRecord.find(2) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
