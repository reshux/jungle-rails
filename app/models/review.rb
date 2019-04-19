class Review < ActiveRecord::Base

    validates :product_id, presence: true,
    validates :user_id, presence: true,
    validates :description, presence: true,
    validates :rating, numericality: true
  
    belongs_to: user
end
