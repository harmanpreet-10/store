class ProductMailer < ApplicationMailer
  def back_in_stock
    @product = params[:product]
    @subscriber = params[:subscriber]

    mail(
      to: @subscriber.email,
      subject: "#{@product.name} is back in stock!"
    )
  end
end