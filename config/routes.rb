Rails.application.routes.draw do
  scope module: :v1, constraints: ApiVersion.new('v1', true) do
    resources :month_budgets, :path => '/month-budgets', except: :show

    get '/month-budgets/:year/:month', to: 'month_budgets#show'

    # resources :budget_records, :path => '/budget-records' do
    #   resources :budget_records
    # end
  end
end
