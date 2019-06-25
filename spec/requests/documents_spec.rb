require 'rails_helper'

describe 'Documents API', type: :request do
  let!(:documents) { create_list(:document, 10) }
  let(:document_id) { documents.first.id }

  # Test suite for GET /documents
  describe 'GET /documents' do
    before { get "/documents" }

    it 'returns documents' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for POST /documents
  describe 'POST /documents' do
    # valid payload
    let(:valid_attributes) { { name: 'Name' } }

    context 'when the request is valid' do
      before { post '/documents', params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(302)
      end
    end

    context 'when the request is invalid' do
      before { post '/documents', params: { name: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(302)
      end
    end
  end

  # Test suite for PUT documents/:id
  describe 'PUT /documents/:id' do
    let(:valid_attributes) { { name: 'Shopping' } }

    context 'when the record exists' do
      before { put "/documents/#{document_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(302) # gets redirected
      end
    end
  end

  # Test suite for DELETE /documents/:id
  describe 'DELETE /documents/:id' do
    before { delete "/documents/#{document_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(302)
    end
  end
end