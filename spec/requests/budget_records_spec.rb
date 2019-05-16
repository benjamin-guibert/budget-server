require 'rails_helper'

RSpec.describe 'Budget records API V1', type: :request do
  let!(:budget_records) { V1::BudgetRecord.all }

  describe 'GET /budget-records' do
    let(:budget_records_params) {}
    before { get '/budget-records',  params: budget_records_params}

    context 'when all' do
      it 'returns the budget records' do
        expect(response).to have_http_status(:ok)

        json = JSON.parse(response.body)
        expect(json).not_to be_empty
        expect(json.map { |i| i["id"]}).to eq([1, 2, 3, 4, 5, 6])
      end
    end

    context 'when by type' do
      let(:budget_records_params) {{
        type: 2
      }}

      it 'returns the budget records' do
        expect(response).to have_http_status(:ok)

        json = JSON.parse(response.body)
        expect(json).not_to be_empty
        expect(json.map { |i| i["id"]}).to eq([2, 3, 5])
      end
    end

    context 'when by type invalid' do
      let(:budget_records_params) {{
        type: 'test'
      }}

      it 'returns nothing' do
        expect(response).to have_http_status(:ok)

        json = JSON.parse(response.body)
        expect(json).to be_empty
      end
    end

    context 'when by date' do
      let(:budget_records_params) {{
        date: {
          year: 2019,
          month: 2
        }
      }}

      it 'returns the budget records' do
        expect(response).to have_http_status(:ok)

        json = JSON.parse(response.body)
        expect(json).not_to be_empty
        expect(json.map { |i| i["id"]}).to eq([3, 4, 5])
      end
    end

    context 'when by date invalid month' do
      let(:budget_records_params) {{
        date: {
          year: 2019,
          month: 'test'
        }
      }}

      it 'returns nothing' do
        expect(response).to have_http_status(:ok)

        json = JSON.parse(response.body)
        expect(json).to be_empty
      end
    end

    context 'when by date invalid year' do
      let(:budget_records_params) {{
        date: {
          year: 'test',
          month: 5
        }
      }}

      it 'returns nothing' do
        expect(response).to have_http_status(:ok)

        json = JSON.parse(response.body)
        expect(json).to be_empty
      end
    end


    context 'when by date invalid' do
      let(:budget_records_params) {{
        date: 'test'
      }}

      it 'returns the budget records' do
        expect(response).to have_http_status(:ok)

        json = JSON.parse(response.body)
        expect(json).not_to be_empty
        expect(json.map { |i| i["id"]}).to eq([1, 2, 3, 4, 5, 6])
      end
    end

    context 'when by incomes' do
      let(:budget_records_params) {{
        incomes: true
      }}

      it 'returns the budget records' do
        expect(response).to have_http_status(:ok)

        json = JSON.parse(response.body)
        expect(json).not_to be_empty
        expect(json.map { |i| i["id"]}).to eq([1, 4, 6])
      end
    end


    context 'when by expenses' do
      let(:budget_records_params) {{
        expenses: true
      }}

      it 'returns the budget records' do
        expect(response).to have_http_status(:ok)

        json = JSON.parse(response.body)
        expect(json).not_to be_empty
        expect(json.map { |i| i["id"]}).to eq([2, 3, 5])
      end
    end
  end

  describe 'GET /budget-records/:id' do
    let(:budget_record_id) { 2 }
    before { get "/budget-records/#{budget_record_id}" }

    context 'when the budget record exists' do
      it 'returns the budget record' do
        expect(response).to have_http_status(:ok)

        json = JSON.parse(response.body)
        expect(json).not_to be_empty
        expect(json['id']).to eq(budget_record_id)
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

  describe 'POST /budget-records' do
    let(:budget_record_params) {{
      label: 'Label POST',
      record_type: 2,
      category: 2,
      date_from: Date.new(2019, 5, 1),
      date_to: Date.new(2019, 5, 31),
      amount: 34.56
    }}
    before { post '/budget-records', params: budget_record_params}

    context 'when the request is valid' do
      it 'creates the budget record' do
        budget_record = V1::BudgetRecord.last
        expect(budget_record).to have_attributes(
          :id => 7,
          :label => 'Label POST',
          :record_type => 2,
          :category => 2,
          :date_from => Date.new(2019, 5, 1),
          :date_to => Date.new(2019, 5, 31),
          :amount => 34.56
        )

        expect(response).to have_http_status(:created)
        json = JSON.parse(response.body)
        expect(json['id']).to eq(7)
        expect(json['label']).to eq('Label POST')
        expect(json['record_type']).to eq(2)
        expect(json['category']).to eq(2)
        expect(json['date_from']).to eq('2019-05-01')
        expect(json['date_to']).to eq('2019-05-31')
        expect(json['amount']).to eq('34.56')
      end
    end

    context 'when a parameter is missing' do
      let(:budget_record_params) {{
        label: 'Label POST'
      }}

      it 'returns an error' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to be
      end
    end
  end

  describe 'PUT /budget-records/:id' do
    let(:budget_record_id) { 2 }
    let(:budget_record_params) {{
      label: 'Label PUT',
      record_type: 1,
      category: 2,
      date_from: Date.new(2019, 12, 1),
      date_to: Date.new(2019, 12, 31),
      amount: 34.56
    }}
    before { put "/budget-records/#{budget_record_id}", params: budget_record_params }

    context 'when the budget record exists' do
      it 'updates the budget record' do
        budget_record = V1::BudgetRecord.find(budget_record_id)
        expect(budget_record).to have_attributes(
          :label => 'Label PUT',
          :record_type => 2,
          :category => 2,
          :date_from => Date.new(2019, 12, 1),
          :date_to => Date.new(2019, 12, 31),
          :amount => 34.56
        )

        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json['label']).to eq('Label PUT')
        expect(json['record_type']).to eq(2)
        expect(json['category']).to eq(2)
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

  describe 'DELETE /budget-records/:id' do
    let(:budget_record_id) { 1 }
    before { delete "/budget-records/#{budget_record_id}" }

    context 'when the budget record exists' do
      it 'deletes the budget record' do
        expect(V1::BudgetRecord.exists?(budget_record_id)).to be_falsey

        expect(response).to have_http_status(:no_content)
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
