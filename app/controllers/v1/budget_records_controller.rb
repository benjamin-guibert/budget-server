class V1::BudgetRecordsController < ApplicationController
  def index
    budget_records = BudgetRecord.all
    json_response(budget_records)
  end

  def create
    budget_record = BudgetRecord.create!(budget_record_params)
    json_response(budget_record, :created)
  end

  def show
    budget_record = BudgetRecord.find(params[:id])
    json_response(budget_record)
  end

  def update
    budget_record = BudgetRecord.find(params[:id])
    budget_record.update(budget_record_params)
    json_response(budget_record)
  end

  def destroy
    budget_record = BudgetRecord.find(params[:id])
    budget_record.destroy
    head :no_content
  end

  private

  def budget_record_params
    params.permit(:label, :record_type, :category, :date_from, :date_to, :amount)
  end
end
