class V1::MonthBudgetsController < ApplicationController
  before_action :set_month_budget, only: [:update, :destroy]

  def index
    month_budgets = apply_scopes(V1::MonthBudget).ordered_by_date
    render json: month_budgets,
      only: [
        :id,
        :year,
        :month,
        :initial_balance
      ],
      status: :ok
  end

  def show
    @month_budget = V1::MonthBudget.find_by_month(params[:year], params[:month])
    render json: @month_budget,
      include: {
        budget_records: {
          only: [
            :id,
            :label,
            :record_type,
            :category,
            :date_from,
            :date_to,
            :amount
          ]
        }
      },
      only: [
        :id,
        :year,
        :month,
        :initial_balance
      ],
      status: :ok
  end

  private

  def set_month_budget
    @month_budget = V1::MonthBudget.find(params[:id])
  end
end
