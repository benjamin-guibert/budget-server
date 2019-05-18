class V1::MonthBudgetsController < ApplicationController
  def index
    month_budgets = apply_scopes(V1::MonthBudget).all
    json_response(month_budgets)
  end
end
