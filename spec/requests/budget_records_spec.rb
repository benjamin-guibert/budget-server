require 'rails_helper'

RSpec.describe 'Budget records API', type: :request do
  let!(:budget_records) { create_list(:budget_record, 10) }
  let(:budget_record_id) { budget_records.first.id }

  describe 'GET /budget_records' do
    before { get '/budget_records' }

    it 'returns budget records' do
      json = JSON.parse(response.body)
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /budget_records/:id' do
    before { get "/budget_records/#{budget_record_id}" }

    context 'when the record exists' do
      it 'returns the budget record' do
        json = JSON.parse(response.body)
        expect(json).not_to be_empty
        expect(json['id']).to eq(budget_record_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:budget_record_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a message' do
        expect(response.body).to be
      end
    end
  end

  describe 'POST /budget_records' do
    let(:valid_attributes) { { label: 'Test label', record_type: 1, category: 2, date_from: Date.new(2019, 5, 1), date_to: Date.new(2019, 5, 31), amount: 34.56 } }

    context 'when the request is valid' do
      before { post '/budget_records', params: valid_attributes }

      it 'creates a budget record' do
        json = JSON.parse(response.body)
        expect(json['id']).to be > 0
        expect(json['label']).to eq('Test label')
        expect(json['record_type']).to eq(1)
        expect(json['category']).to eq(2)
        expect(json['date_from']).to eq('2019-05-01')
        expect(json['date_to']).to eq('2019-05-31')
        expect(json['amount']).to eq('34.56')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/budget_records', params: { label: 'Test label' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a message' do
        expect(response.body)
          .to be
      end
    end
  end

  describe 'PUT /budget_records/:id' do
    let(:valid_attributes) { { label: 'New label' } }

    context 'when the record exists' do
      before { put "/budget_records/#{budget_record_id}", params: valid_attributes }

      it 'updates the budget record' do
        json = JSON.parse(response.body)
        expect(json['id']).to eq(budget_record_id)
        expect(json['label']).to eq('New label')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'DELETE /budget_records/:id' do
    before { delete "/budget_records/#{budget_record_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
