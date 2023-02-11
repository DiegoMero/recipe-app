require 'rails_helper'

RSpec.describe 'Foods', type: :request do
  login_user
  describe 'GET /index' do
    it 'returns http success' do
      get '/foods'
      expect(response).to have_http_status(:success)
    end

    it 'renders the correct template' do
      get '/foods'
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get '/foods/new'
      expect(response).to have_http_status(:success)
    end

    it 'renders the correct template' do
      get '/foods/new'
      expect(response).to render_template(:new)
    end
  end

  describe 'GET /foods#general_shopping_list' do
    it 'returns http success' do
      get '/general_shopping_list'
      expect(response).to have_http_status(:success)
    end

    it 'renders the correct template' do
      get '/general_shopping_list'
      expect(response).to render_template('foods/general_shopping_list')
    end
  end
end
