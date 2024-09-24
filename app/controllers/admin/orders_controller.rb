class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
    
  def index
    @customer = Customer.find(params[:customer_id])
    @orders = @customer.orders
  end 

  def show
    @order = Order.find(params[:id])
    @orders = Order.all
    @order_details = OrderDetail.where(order_id: @order.id)
  end

  def update
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: @order.id)
    if @order.update(status_params)
      if @order.status == "paied"

        @order_details.update( making_status: 1)
      end
    flash[:notice] = "注文ステータスを変更しました。"
    redirect_to admin_order_path(@order)
    else
      render "show"
    end
  end


  private

  def status_params
    params.require(:order).permit(:status)
  end
end
