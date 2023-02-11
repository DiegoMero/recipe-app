class RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:public_recipe]

  def index
    @user = current_user
    @user_recipes = @user.recipes
  end

  def new
    @recipe = Recipe.new
  end

  def create
    unless current_user
      redirect_to new_user_registration_url, notice: 'Please, signup to create a recipe'
      return
    end

    recipe = Recipe.new(recipe_params)
    recipe.user = current_user
    if recipe.save
      redirect_to recipes_url
    else
      render :new, locals: { recipe: }
    end
  end

  def show
    @recipe = Recipe.find_by(id: params[:id])
    @foods = @recipe.recipe_foods.map(&:food)
  end

  def destroy
    recipe = Recipe.find(params[:id])
    puts recipe
    recipe.destroy
    redirect_to recipes_url, notice: 'Recipe deleted successfully'
  end

  def public_recipes
    @public_recipes = Recipe.where(public: true).order(created_at: :desc)
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
