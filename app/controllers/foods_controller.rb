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
    @missing_foods = []
    current_user.recipes.each do |recipe|
      recipe.recipe_foods.each do |recipe_food|
        @food = recipe_food.food
        @missing_foods << recipe_food unless current_user.foods.include?(@food)
      end
    end
    @total_price = 0
    @missing_foods.each do |missing_food|
      @food = missing_food.food
      @total_price += @food.price * missing_food.quantity
    end
  end

  private

  def form_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
