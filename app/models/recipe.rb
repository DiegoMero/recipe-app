class Recipe < ApplicationRecord
  has_many :recipe_foods, dependent: :delete_all
  belongs_to :user
end
