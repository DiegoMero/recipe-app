require 'rails_helper'

RSpec.describe 'Recipes', type: :request do
  login_user
  let(:valid_attributes) do
    User.create(name: 'David', email: 'example@example.com', password: 'password')
    {
      name: 'Encebollado',
      preparation_time: 1,
      cooking_time: 1,
      description: 'testing recipe',
      user_id: 1
    }
  end

  describe 'GET /index' do
    it 'returns http success' do
      get '/recipes'
      expect(response).to have_http_status(:success)
    end

    it 'renders the correct template' do
      get '/recipes'
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      @recipe = Recipe.create valid_attributes
      get "/recipes/#{@recipe.id}"
      expect(response).to have_http_status(:success)
    end

    it 'renders the correct template' do
      @recipe = Recipe.create valid_attributes
      get "/recipes/#{@recipe.id}"
      expect(response).to render_template(:show)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get '/recipes/new'
      expect(response).to have_http_status(:success)
    end

    it 'renders the correct template' do
      get '/recipes/new'
      expect(response).to render_template(:new)
    end
  end

  describe 'GET /recipes#public_recipes' do
    it 'returns http success' do
      get '/public_recipes'
      expect(response).to have_http_status(:success)
    end

    it 'renders the correct template' do
      get '/public_recipes'
      expect(response).to render_template('recipes/public_recipes')
    end
  end
end
