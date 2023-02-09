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

  private

  def form_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
