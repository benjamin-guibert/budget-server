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
        json.each do |month_budget|
          expect(month_budget['year'].present?).to be true
          expect(month_budget['month'].present?).to be true
          expect(month_budget['initial_balance'].present?).to be true
          expect(month_budget['budget_records'].present?).to be false
          expect(month_budget['created_at'].present?).to be false
          expect(month_budget['updated_at'].present?).to be false
        end
      end
    end
  end

  describe 'Get /month-budgets/:id' do
    let(:month_budget_id) { 2 }
    before { get "/month-budgets/#{month_budget_id}" }

    context 'when the month budget exists' do
      it 'returns the month budget with its records' do
        expect(response).to have_http_status(:ok)

        json = JSON.parse(response.body)
        expect(json['id']).to eq(2)
        expect(json['year']).to eq(2019)
        expect(json['month']).to eq("february")
        expect(json['initial_balance']).to eq("2845.95")
        expect(json['created_at'].present?).to be false
        expect(json['updated_at'].present?).to be false
        expect(json['budget_records']).not_to be_empty

        category_exists = false
        json['budget_records'].each do |budget_record|
          expect(budget_record['id'].present?).to be true
          expect(budget_record['label'].present?).to be true
          expect(budget_record['record_type'].present?).to be true
          expect(budget_record['date_from'].present?).to be true
          expect(budget_record['date_to'].present?).to be true
          expect(budget_record['amount'].present?).to be true
          expect(budget_record['month_budget_id'].present?).to be false
          expect(budget_record['created_at'].present?).to be false
          expect(budget_record['updated_at'].present?).to be false

          category_exists = true if budget_record['category'].present?
        end
        expect(category_exists).to be true
      end
    end

    context 'when the month budget does not exist' do
      let(:month_budget_id) { 999 }

      it 'returns an error' do
        expect(response).to have_http_status(:not_found)
        expect(response.body).to be
      end
    end
  end

  describe 'GET /month-budgets/:year/:month' do
    let(:year) { 2019}
    let(:month) { :february }
    before { get "/month-budgets/#{year}/#{month}" }

    context 'when the month budget exists' do
      it 'returns the month budget with its records' do
        expect(response).to have_http_status(:ok)

        json = JSON.parse(response.body)
        expect(json['id']).to eq(2)
        expect(json['year']).to eq(2019)
        expect(json['month']).to eq("february")
        expect(json['initial_balance']).to eq("2845.95")
        expect(json['created_at'].present?).to be false
        expect(json['updated_at'].present?).to be false
        expect(json['budget_records']).not_to be_empty

        category_exists = false
        json['budget_records'].each do |budget_record|
          expect(budget_record['id'].present?).to be true
          expect(budget_record['label'].present?).to be true
          expect(budget_record['record_type'].present?).to be true
          expect(budget_record['date_from'].present?).to be true
          expect(budget_record['date_to'].present?).to be true
          expect(budget_record['amount'].present?).to be true
          expect(budget_record['month_budget_id'].present?).to be false
          expect(budget_record['created_at'].present?).to be false
          expect(budget_record['updated_at'].present?).to be false

          category_exists = true if budget_record['category'].present?
        end
        expect(category_exists).to be true
      end
    end

    context 'when the month budget does not exist' do
      let(:year) { 2010 }
      it 'returns an error' do
        expect(response).to have_http_status(:not_found)
        expect(response.body).to be
      end
    end
  end
end
