class V1::BudgetRecordsController < ApplicationController

  # def create
  #   budget_record = V1::BudgetRecord.create!(budget_record_params)
  #   json_response(budget_record, :created)
  # end

  def show
    @budget_record = V1::BudgetRecord.find(params[:id])
    render_budget_record()
  end

  def update
    @budget_record = V1::BudgetRecord.find(params[:id])
    @budget_record.update!(budget_record_params)
    render_budget_record()
  end

  # def destroy
  #   budget_record = V1::BudgetRecord.find(params[:id])
  #   budget_record.destroy
  #   head :no_content
  # end

  private

  def render_budget_record
    render json: @budget_record,
      only: [
        :id,
        :label,
        :record_type,
        :category,
        :date_from,
        :date_to,
        :amount
      ],
      status: :ok
  end

  def budget_record_params
    params.permit(:label, :category, :amount)
  end
end
