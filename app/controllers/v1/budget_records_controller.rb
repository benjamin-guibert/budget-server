class V1::BudgetRecordsController < ApplicationController

  def create
    @budget_record = V1::BudgetRecord.create!(budget_record_params)
    render_budget_record(:created)
  end

  def index
    budget_records = apply_scopes(V1::BudgetRecord)
    render json: budget_records,
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

  def show
    @budget_record = V1::BudgetRecord.find(params[:id])
    if(params[:month_budget_id] && @budget_record.month_budget_id != params[:month_budget_id].to_i)
      render status: :not_found
    else
      render_budget_record()
    end
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

  def render_budget_record(status=:ok)
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
      status: status
  end

  def budget_record_params
    params.permit(:month_budget_id, :label, :record_type, :category, :amount, :date_from, :date_to)
  end
end
