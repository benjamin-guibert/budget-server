class V1::MonthBudgetsController < ApplicationController

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
    @month_budget = V1::MonthBudget.find(params[:id])

    render_month_budget
  end

  def show_by_month
    @month_budget = V1::MonthBudget.find_by_month(params[:year], params[:month])
    render_month_budget
  end

  private
  def render_month_budget(status=:ok)
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
      status: status
  end
end
