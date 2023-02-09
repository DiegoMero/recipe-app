class RecipesController < ApplicationController
  before_action :authenticate_user, except: [:public_recipe]

  def index
    @recipes = Recipe.where(user_id: current_user.id).or(Recipe.where(public: true))
  end

  def new
    @recipe = Recipe.new
  end
end
