class Notifier < ApplicationMailer
  default :from => "Book Store <trantrungtinbkit@gmail.com>"

  def order_received(order)    
      @order = order
    
      mail :to => @order.email, :subject => "We've received your order"
  end
  
end
