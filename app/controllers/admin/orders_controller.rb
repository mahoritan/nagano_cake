class Admin::OrdersController < Admin:ApplicationController

  def show
    @order = Order.find(params[:id])
    @sum = 0
    @order.order_details.each do |order_detail|
      @sum += (order_detail.item.price * 1.1) * order_detail.amount
    end
    @order.total_payment = @sum + @order.shipping_cost
  end

end
