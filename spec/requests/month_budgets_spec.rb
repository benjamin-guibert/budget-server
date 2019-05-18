RSpec.describe 'Month budgets API V1', type: :request do
  describe 'GET /month-budgets' do
    let(:month_budgets_params) {}
    before { get '/month-budgets',  params: month_budgets_params}

    context 'when all' do
      it 'returns the month budgets' do
        expect(response).to have_http_status(:ok)

        json = JSON.parse(response.body)
        expect(json).not_to be_empty
        expect(json.map { |i| i["id"]}).to eq([6, 1, 2, 3, 5, 4])
      end
    end
  end

  # describe 'GET /month-budgets/:year/:month'
end
