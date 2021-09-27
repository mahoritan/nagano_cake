class Publics::OrdersController < ApplicationController

  def new
    @order = Order.new
  end

  def confirm
    if params[:order][:select_address] == "0"
      @order = Order.new(order_params)
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.full_name
    elsif params[:order][:select_address] == "1"
      @order = Order.new(order_params)
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    else
      @order = Order.new(order_params)
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    end
    @cart_items = current_customer.cart_items.all
    @order.shipping_cost = 800
    @sum = 0
    current_customer.cart_items.each do |cart_item|
      @sum += (cart_item.item.price * 1.1) * cart_item.amount
    end
    @order.total_payment = @sum + @order.shipping_cost
  end

  def thanks
  end

  def create
    @order = Order.new(order_params)
    @order.save
    @cart_items = current_customer.cart_items.all
    @cart_items.each do |cart_item|
    @order_detail = OrderDetail.create(
      amount: cart_item.amount,
      item_id: cart_item.item.id,
      price: (cart_item.item.price * 1.1) * cart_item.amount,
      order_id: @order.id
    )
    end
    current_customer.cart_items.destroy_all
    redirect_to orders_thanks_path
  end

  def index
    @orders = current_customer.orders.all
    @order_details = OrderDetail.all
    @order_detail = OrderDetail.select(:name).distinct
  end

  def show
    @order = Order.find(params[:id])
    @sum = 0
    @order.order_details.each do |order_detail|
      @sum += (order_detail.item.price * 1.1) * order_detail.amount
    end
    @order.total_payment = @sum + @order.shipping_cost
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :total_payment, :shipping_cost, :customer_id)
  end

end
