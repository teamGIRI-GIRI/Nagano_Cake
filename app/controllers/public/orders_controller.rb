class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @addresses = Address.where(customer_id: current_customer.id)
  end

  def confirm
    @order = Order.new(order_params)
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @order.payment_method = Order.payment_methods[params[:order][:payment_method]]
    @order.shipping_cost = 800
    @subtotal_sum = @cart_items.sum { |cart_item| cart_item.subtotal }
    @order.total_payment = @order.shipping_cost + @subtotal_sum

    select_address = params[:order][:select_address]
    register_address = Address.find(params[:order][:address_id])
    case select_address
      when "0" then
        @order.postal_code = current_customer.postal_code
        @order.address = current_customer.address
        @order.name = current_customer.last_name + current_customer.first_name
      when "1" then
        @order.postal_code = register_address.postal_code
        @order.address = register_address.address
        @order.name = register_address.name
    end

    render 'public/orders/confirm'
  end

  def create
    order = Order.new(order_params)
    order.customer_id = current_customer.id
    order.save
    cart_items = CartItem.where(customer_id: current_customer.id)
    cart_items.each do |cart_item|
      order_detail = OrderDetail.new
      order_detail.order_id = order.id
      order_detail.item_id = cart_item.item_id
      order_detail.price = cart_item.subtotal
      order_detail.amount = cart_item.amount
      order_detail.save
    end
    cart_items.destroy_all
    redirect_to thanks_path
  end

  def thanks
    render 'public/orders/thanks'
  end

  def index
    @orders = current_customer.orders
  end
  
  def show
    @order = current_customer.orders.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :payment_method, :shipping_cost, :total_payment)
  end
  
end