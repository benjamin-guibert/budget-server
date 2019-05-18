Rails.application.routes.draw do
  scope module: :v1, constraints: ApiVersion.new('v1', true) do
    resources :month_budgets, path: '/month-budgets', only: [:index, :show]

    get '/month-budgets/:year/:month', to: 'month_budgets#show_by_month'

    # resources :budget_records, :path => '/budget-records' do
    #   resources :budget_records
    # end
  end
end
