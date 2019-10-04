RSpec.describe 'Budget records API V1', type: :request do
  describe 'Get /budget-records/:id' do
    let(:budget_record_id) { 3 }
    before { get "/budget-records/#{budget_record_id}" }

    context 'when the budget record exists' do
      it 'returns the budget record' do
        expect(response).to have_http_status(:ok)

        json = JSON.parse(response.body)
        expect(json['id']).to eq(3)
        expect(json['label']).to eq("Expense 2")
        expect(json['record_type']).to eq("expense")
        expect(json['category']).to eq("wants")
        expect(json['date_from']).to eq("2019-02-01")
        expect(json['date_to']).to eq("2019-02-28")
        expect(json['amount']).to eq("23.45")
      end
    end

    context 'when the budget record does not exist' do
      let(:budget_record_id) { 999 }

      it 'returns an error' do
        expect(response).to have_http_status(:not_found)
        expect(response.body).to be
      end
    end
  end

  describe 'Get /month-budgets/:month_budget_id/budget-records/:id' do
    let(:month_budget_id) { 2 }
    let(:budget_record_id) { 3 }
    before { get "/month-budgets/#{month_budget_id}/budget-records/#{budget_record_id}" }

    context 'when the budget record exists' do
      it 'returns the budget record' do
        expect(response).to have_http_status(:ok)

        json = JSON.parse(response.body)
        expect(json['id']).to eq(3)
        expect(json['label']).to eq("Expense 2")
        expect(json['record_type']).to eq("expense")
        expect(json['category']).to eq("wants")
        expect(json['date_from']).to eq("2019-02-01")
        expect(json['date_to']).to eq("2019-02-28")
        expect(json['amount']).to eq("23.45")
      end
    end

    context 'when the budget record does not exist for the month budget' do
    let(:month_budget_id) { 1 }
      let(:budget_record_id) { 3 }

      it 'returns an error' do
        expect(response).to have_http_status(:not_found)
        expect(response.body).to be
      end
    end
  end

  # FIXME: Record not created in test base.
  # describe 'POST /budget-records' do
  #   let(:budget_record_params) {{
  #     month_budget_id: 2,
  #     label: 'Label POST',
  #     record_type: :expense,
  #     category: :needs,
  #     date_from: Date.new(2019, 12, 1),
  #     date_to: Date.new(2019, 12, 31),
  #     amount: 34.56
  #   }}
  #   before { post "/budget-records", params: budget_record_params }
  #   context 'when the budget record is valid' do
  #     it 'creates the budget record' do
  #       budget_record = V1::BudgetRecord.find(7)
  #       expect(budget_record).to have_attributes(
  #         :budget_record_id => 2,
  #         :label => 'Label POST',
  #         :record_type => 'expense',
  #         :category => 'needs',
  #         :amount => 34.56,
  #         :date_from => Date.new(2019, 02, 1),
  #         :date_to => Date.new(2019, 02, 28)
  #       )

  #       expect(response).to have_http_status(:ok)
  #       json = JSON.parse(response.body)
  #       expect(json['id']).to eq(7)
  #       expect(json['label']).to eq('Label POST')
  #       expect(json['record_type']).to eq('expense')
  #       expect(json['category']).to eq('needs')
  #       expect(json['date_from']).to eq('2019-02-01')
  #       expect(json['date_to']).to eq('2019-02-28')
  #       expect(json['amount']).to eq('34.56')
  #     end
  #   end
  # end

  describe 'PUT /budget-records/:id' do
    let(:budget_record_id) { 3 }
    let(:budget_record_params) {{
      label: 'Label PUT',
      category: :needs,
      date_from: Date.new(2019, 12, 1),
      date_to: Date.new(2019, 12, 31),
      amount: 34.56
    }}
    before { put "/budget-records/#{budget_record_id}", params: budget_record_params }
    context 'when the budget record exists' do
      it 'updates the budget record' do
        budget_record = V1::BudgetRecord.find(budget_record_id)
        expect(budget_record).to have_attributes(
          :month_budget_id => 2,
          :label => 'Label PUT',
          :record_type => 'expense',
          :category => 'needs',
          :amount => 34.56,
          :date_from => Date.new(2019, 12, 1),
          :date_to => Date.new(2019, 12, 31)
        )

        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json['id']).to eq(3)
        expect(json['label']).to eq('Label PUT')
        expect(json['record_type']).to eq('expense')
        expect(json['category']).to eq('needs')
        expect(json['date_from']).to eq('2019-12-01')
        expect(json['date_to']).to eq('2019-12-31')
        expect(json['amount']).to eq('34.56')
      end
    end

    context 'when the budget record does not exist' do
      let(:budget_record_id) { 999 }

      it 'returns an error' do
        expect(response).to have_http_status(:not_found)
        expect(response.body).to be
      end
    end
  end
end

#   describe 'POST /budget-records' do
#     let(:budget_record_params) {{
#       month_budget_id: 2,
#       label: 'Label POST',
#       record_type: :expense,
#       category: :wants,
#       date_from: Date.new(2019, 5, 1),
#       date_to: Date.new(2019, 5, 31),
#       amount: 34.56
#     }}
#     before { post '/budget-records', params: budget_record_params}

#     # context 'when the request is valid' do
#     #   it 'creates the budget record' do
#     #     budget_record = V1::BudgetRecord.find(7)
#     #     expect(budget_record).to have_attributes(
#     #       :id => 7,
#     #       :label => 'Label POST',
#     #       :record_type => :expense,
#     #       :category => :wants,
#     #       :date_from => Date.new(2019, 5, 1),
#     #       :date_to => Date.new(2019, 5, 31),
#     #       :amount => 34.56
#     #     )

#     #     expect(response).to have_http_status(:created)
#     #     json = JSON.parse(response.body)
#     #     expect(json['id']).to eq(7)
#     #     expect(json['label']).to eq('Label POST')
#     #     expect(json['record_type']).to eq('expense')
#     #     expect(json['category']).to eq('wants')
#     #     expect(json['date_from']).to eq('2019-05-01')
#     #     expect(json['date_to']).to eq('2019-05-31')
#     #     expect(json['amount']).to eq('34.56')
#     #   end
#     # end

#     context 'when a parameter is missing' do
#       let(:budget_record_params) {{
#         label: 'Label POST'
#       }}

#       it 'returns an error' do
#         expect(response).to have_http_status(:unprocessable_entity)
#         expect(response.body).to be
#       end
#     end
#   end

#   describe 'PUT /budget-records/:id' do
#     let(:budget_record_id) { 2 }
#     let(:budget_record_params) {{
#       label: 'Label PUT',
#       category: :needs,
#       date_from: Date.new(2019, 12, 1),
#       date_to: Date.new(2019, 12, 31),
#       amount: 34.56
#     }}
#     before { put "/budget-records/#{budget_record_id}", params: budget_record_params }

#     # context 'when the budget record exists' do
#     #   it 'updates the budget record' do
#     #     budget_record = V1::BudgetRecord.find(budget_record_id)
#     #     expect(budget_record).to have_attributes(
#     #       :label => 'Label PUT',
#     #       :record_type => 'expense',
#     #       :category => 'needs',
#     #       :date_from => Date.new(2019, 12, 1),
#     #       :date_to => Date.new(2019, 12, 31),
#     #       :amount => 34.56
#     #     )

#     #     expect(response).to have_http_status(:ok)
#     #     json = JSON.parse(response.body)
#     #     expect(json['id']).to eq(2)
#     #     expect(json['label']).to eq('Label PUT')
#     #     expect(json['record_type']).to eq('expense')
#     #     expect(json['category']).to eq('needs')
#     #     expect(json['date_from']).to eq('2019-12-01')
#     #     expect(json['date_to']).to eq('2019-12-31')
#     #     expect(json['amount']).to eq('34.56')
#     #   end
#     # end

#     context 'when the budget record does not exist' do
#       let(:budget_record_id) { 999 }

#       it 'returns an error' do
#         expect(response).to have_http_status(:not_found)
#         expect(response.body).to be
#       end
#     end
#   end

#   describe 'DELETE /budget-records/:id' do
#     let(:budget_record_id) { 1 }
#     before { delete "/budget-records/#{budget_record_id}" }

#     context 'when the budget record exists' do
#       it 'deletes the budget record' do
#         expect(V1::BudgetRecord.exists?(budget_record_id)).to be_falsey

#         expect(response).to have_http_status(:no_content)
#       end
#     end

#     context 'when the budget record does not exist' do
#       let(:budget_record_id) { 999 }

#       it 'returns an error' do
#         expect(response).to have_http_status(:not_found)
#         expect(response.body).to be
#       end
#     end
#   end
# end
