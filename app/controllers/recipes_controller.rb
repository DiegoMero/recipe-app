class RecipesController < ApplicationController
  def public_recipes
    @public_recipes = Recipe.where(public: true).order(created_at: :desc)
  end
end
