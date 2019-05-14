Rails.application.routes.draw do
  scope module: :v1, constraints: ApiVersion.new('v1', true) do
    resources :budget_records do
      resources :budget_records
    end
  end
end
