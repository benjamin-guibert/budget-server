class V1::MonthBudgetsController < ApplicationController
  before_action :set_month_budget, only: [:show, :update, :destroy]

  def index
    month_budgets = apply_scopes(V1::MonthBudget).ordered_by_date
    json_response(month_budgets)
  end

  private

  def set_month_budget
    @month_budget = V1::MonthBudget.find(params[:id])
  end
end
