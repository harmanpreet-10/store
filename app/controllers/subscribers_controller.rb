class SubscribersController < ApplicationController
  def create
    @product = Product.find(params[:product_id])
    @subscriber = @product.subscribers.build(subscriber_params)

    if @subscriber.save
      redirect_to @product, notice: "You have successfully subscribed!"
    else
      redirect_to @product, alert: "Could not subscribe."
    end
  end

  def destroy
    @product = Product.find(params[:product_id])
    @subscriber = @product.subscribers.find(params[:id])
    @subscriber.destroy

    redirect_to @product, notice: "You have successfully unsubscribed."
  end

  private

  def subscriber_params
    params.require(:subscriber).permit(:email)
  end
end