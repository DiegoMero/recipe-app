class RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:public_recipe]

  def index
    @recipes = Recipe.where(user_id: current_user.id).or(Recipe.where(public: true))
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to recipes_url, notice: "Recipe was successfully created."
    else
      render :new
    end
  end
  

  def show
    @recipe = Recipe.find_by(id: params[:id])
  end

  def delete
    recipe = Recipe.find(params[:id])
    recipe.destroy
    redirect_to recipes_url, notice: 'Recipe deleted successfully'
  end

  def public_recipe
    @recipes = Recipe.where(public: true)
  end
end
  