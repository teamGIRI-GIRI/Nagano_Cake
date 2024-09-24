class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
  end

  def create
    @cart_items = current_customer.cart_items.all
    amount = cart_item_params[:amount].to_i
    params[:cart_item][:customer_id] = current_customer.id

    if amount <= 0
    flash[:alert] = "個数を選択してください。"
    redirect_to item_path(params[:cart_item][:item_id]) and return
    end
    # if cart_item_params[:amount] != ""
      if @cart_items.any? { |cart_item| cart_item.item_id == params[:cart_item][:item_id].to_i }
        @cart_item_already = CartItem.find_by(item_id: params[:cart_item][:item_id])
        @cart_item_already.amount += params[:cart_item][:amount].to_i
        @cart_item_already.save
        flash[:success] = "カートに商品が登録されました。"
        redirect_to cart_items_path
      else
        @cart_item = CartItem.new(cart_item_params)
        @cart_item.save
        flash[:success] = "カートに商品が登録されました。"
        redirect_to cart_items_path
      end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    flash[:success] = "数量が変更されました。"
    redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    flash[:danger] = "商品が削除されました。"
    redirect_to cart_items_path
  end

  def destroy_all
    @cart_items = current_customer.cart_items.all
    @cart_items.destroy_all
    flash[:danger] = "カート内の商品が全て削除されました。"
    redirect_to cart_items_path
  end


  private

  def cart_item_params
    params.require(:cart_item).permit(:amount, :item_id, :customer_id)
  end


end


