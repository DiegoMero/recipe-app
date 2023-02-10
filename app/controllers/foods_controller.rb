class FoodsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @user_foods = @user.foods
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(form_params.merge(user: current_user))

    if @food.save
      redirect_to foods_url
    else
      render :new
    end
  end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy
    redirect_to foods_url
  end

  def general_shopping_list
    @user_recipes = current_user.recipes
    @missing_foods_cost = 0
    @missing_recipe_foods = []
    @user_recipes.each do |recipe|
      recipe.recipe_foods.each do |recipe_food|
        @food = Food.find(recipe_food.food_id)
        @missing_foods_cost += recipe_food.quantity * @food.price if @food.user_id != current_user.id
        @missing_food = recipe_food.food unless current_user.foods.include?(recipe_food.food)
        @missing_recipe_foods << [recipe_food, @missing_food] if @missing_food
      end
    end
  end

  private

  def form_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
