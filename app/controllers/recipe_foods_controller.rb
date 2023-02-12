class RecipeFoodsController < ApplicationController
  before_action :authenticate_user!

  def index; end

  def new
    @foods = Food.where(user_id: current_user.id)
    @recipe_food = RecipeFood.new
  end

  def create
    unless current_user
      redirect_to new_user_registration_url, notice: 'Please, signup to create a recipe'
      return
    end

    data = params.require(:recipe_food).permit(:quantity, :food)
    recipe_food = RecipeFood.new(quantity: data[:quantity], recipe_id: params[:recipe_id], food_id: data[:food])
    recipe_food.recipe_id = params[:recipe_id]
    if recipe_food.save
      redirect_to recipe_url(params[:recipe_id])
    else
      render :new, locals: { recipe_food: }
    end
  end
end
