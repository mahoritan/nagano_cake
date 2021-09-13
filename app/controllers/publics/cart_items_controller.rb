class Publics::CartItemsController < ApplicationController

  def create
    @cart_item = CartItem.new(cart_item_params)
    @current_customer_id = current_customer.id
    @cart_item.save
    redirect_to cart_items_path
  end

  def index
  end

  def update
  end

  def destroy
  end

  def destroy_all
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
