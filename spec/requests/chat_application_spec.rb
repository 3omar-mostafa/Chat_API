require 'rails_helper'

BASE_URL = '/api/v1/applications'

RSpec.describe "ChatApplications", type: :request do

  describe "GET /" do
    it "returns http success with no data" do
      get "#{BASE_URL}/"
      expect(response).to have_http_status(:success)
      data = JSON.parse(response.body)
      expect(data['status']).to eq('success')
      expect(data['data'].length).to eq(0)
    end

    it "returns http success with data" do
      chat_app = FactoryBot.create(:chat_application).as_json
      get "#{BASE_URL}/"
      expect(response).to have_http_status(:success)
      data = JSON.parse(response.body)
      expect(data['status']).to eq('success')
      expect(data['data'].length).to eq(1)
      expect(data['data'].first).to eq(chat_app)
    end
  end

  describe "GET /:token" do
    it "returns http success with data" do
      chat_app = FactoryBot.create(:chat_application).as_json
      get "#{BASE_URL}/#{chat_app['token']}"
      expect(response).to have_http_status(:success)
      data = JSON.parse(response.body)
      expect(data['status']).to eq('success')
      expect(data['data']).to eq(chat_app)
    end

    it "returns http error not found" do
      get "#{BASE_URL}/invalid_token"
      expect(response).to have_http_status(:not_found)
      data = JSON.parse(response.body)
      expect(data['status']).to eq('error')
    end
  end

  describe "POST /" do
    it "returns http success with data" do
      chat_app = FactoryBot.build(:chat_application).as_json
      post "#{BASE_URL}/", params: chat_app
      expect(response).to have_http_status(:created)
      data = JSON.parse(response.body)
      expect(data['status']).to eq('success')
      data = data['data']
      expect(data['name']).to eq(chat_app['name'])
      expect(data['token']).not_to eq(chat_app['token']) # token is generated by the server even if it is provided
    end

    it "returns http error with invalid data" do
      chat_app = FactoryBot.build(:chat_application).as_json
      chat_app.delete('name')
      post "#{BASE_URL}/", params: chat_app
      expect(response).to have_http_status(:bad_request)
      data = JSON.parse(response.body)
      expect(data['status']).to eq('error')
    end
  end

  describe "PATCH /:token" do

    let!(:chat_app) { FactoryBot.create(:chat_application).as_json }

    it "returns http success with data" do
      new_name = 'new_name'
      chat_app['name'] = new_name
      patch "#{BASE_URL}/#{chat_app['token']}", params: chat_app
      expect(response).to have_http_status(:ok)
      data = JSON.parse(response.body)
      expect(data['status']).to eq('success')
      expect(data['data']['name']).to eq(new_name)
    end

    it "returns http error with invalid data" do
      chat_app.delete('name')
      patch "#{BASE_URL}/#{chat_app['token']}", params: chat_app
      expect(response).to have_http_status(:bad_request)
      data = JSON.parse(response.body)
      expect(data['status']).to eq('error')
    end

    it "returns http error not found" do
      patch "#{BASE_URL}/invalid_token", params: chat_app
      expect(response).to have_http_status(:not_found)
      data = JSON.parse(response.body)
      expect(data['status']).to eq('error')
    end
  end

  describe "DELETE /:token" do
    it "returns http success" do
      chat_app = FactoryBot.create(:chat_application).as_json
      delete "#{BASE_URL}/#{chat_app['token']}"
      expect(response).to have_http_status(:ok)
      data = JSON.parse(response.body)
      expect(data['status']).to eq('success')
    end

    it "returns http error not found" do
      delete "#{BASE_URL}/invalid_token"
      expect(response).to have_http_status(:not_found)
      data = JSON.parse(response.body)
      expect(data['status']).to eq('error')
    end
  end

end
