class V1::BudgetRecordsController < ApplicationController
  has_scope :by_type, as: 'type', only: :index
  has_scope :incomes, type: :boolean, only: :index
  has_scope :expenses, type: :boolean, only: :index
  has_scope :by_date, as: 'date', using: %i[year month], type: :hash, only: :index do |controller, scope, value|
    begin
      date = Date.new(value[0].to_i, value[1].to_i)
      scope.by_date(date.beginning_of_month, date.end_of_month)
    rescue ArgumentError
      scope.none
    end
  end

  def index
    budget_records = apply_scopes(V1::BudgetRecord).all
    json_response(budget_records)
  end

  def create
    budget_record = V1::BudgetRecord.create!(budget_record_params)
    json_response(budget_record, :created)
  end

  def show
    budget_record = V1::BudgetRecord.find(params[:id])
    json_response(budget_record)
  end

  def update
    budget_record = V1::BudgetRecord.find(params[:id])
    budget_record.update!(budget_record_params)
    json_response(budget_record)
  end

  def destroy
    budget_record = V1::BudgetRecord.find(params[:id])
    budget_record.destroy
    head :no_content
  end

  private

  def budget_record_params
    params.permit(:label, :record_type, :category, :date_from, :date_to, :amount)
  end
end
