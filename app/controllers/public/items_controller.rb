class Public::ItemsController < ApplicationController
  before_action :is_matching_login_customer, only: [:show]

  def index
    @items = Item.all
    @item = @items.page(params[:page]).per(8)
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end


  private

  def is_matching_login_customer
    # @customer = Customer.find(params[:id])
    unless @customer == current_customer
      redirect_to new_admin_session
    end
  end


end
