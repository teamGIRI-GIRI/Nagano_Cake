class Public::CartItemsController < ApplicationController

  def index
    # どの会員のた―都内アイテムか限定する必要がある
    @cart_items = CartItem.all
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    # @cart_item.customer_id = current_customer.id
    if @cart_item.save
        redirect_to cart_items_path
    else
      redirect_to root_path
    end
  end

  def destroy
  end


  private

  def cart_item_params
    params.require(:cart_item).permit(:amount, :item_id, :customer_id)
  end



end
