class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end
  
  def index
    @orders = current_customer.orders
  end
  
  def show
    @order = current_customer.orders.find(params[:id])
  end
end
