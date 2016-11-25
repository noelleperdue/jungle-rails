class UserMailer < ApplicationMailer
  default from: 'no-reply@jungle.com'

  def confirmation_email(order)
   @order = order
   @line_items = @order.line_items


   mail(to: 'perdue.noelle@gmail.com', subject: "Order Confirmation #{order.id}")
 end
end