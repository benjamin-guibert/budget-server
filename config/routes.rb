Rails.application.routes.draw do
  scope module: :v1, constraints: ApiVersion.new('v1', true) do
    resources :month_budgets, path: '/month-budgets', only: [:index, :show] do
      resources :budget_records, path: '/budget-records', only: [:show, :create, :update]
    end
    get '/month-budgets/:year/:month', to: 'month_budgets#show_by_month'

    resources :budget_records, path: '/budget-records', only: [:show, :create, :update]
  end
end
