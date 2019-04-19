class ReviewsController < ApplicationController

    def create
        review = Review.new(review_params)
        review.user_id = session[:user_id]
        review.product_id = params[:product_id]
        if review.save
            review.save
            redirect_to "/products/#{params[:product_id]}"
        else
            redirect_to "/products/#{params[:product_id]}"
      end
    end

    def destroy
        @review = Review.find params[:id]
        @review.destroy
        redirect_to "/products/#{params[:product_id]}"
    end

    private

    def review_params
      params.require(:review).permit(
          :id,
          :rating, 
          :description
          )
    end

end
