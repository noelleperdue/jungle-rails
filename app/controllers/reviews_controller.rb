class ReviewsController < ApplicationController

  before_action :authorize

  def create
    @review = Review.new(description: params[:review][:description],
      rating: params[:review][:rating],
      user_id: session[:user_id],
      product_id: params[:product_id])

    @review.user = current_user
      @review.save
      redirect_to product_path (params[:product_id])
  end

  def destroy
    @review = Review.find params[:id]
    @review.destroy
    redirect_to product_path(params[:product_id])
  end
end