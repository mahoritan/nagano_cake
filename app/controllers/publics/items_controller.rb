class Publics::ItemsController < ApplicationController
  before_action :authenticate_customer!,except: [:index, :show]

  def index
    @items = Item.page(params[:page]).per(12).reverse_order
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

end
