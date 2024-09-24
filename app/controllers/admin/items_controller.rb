class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @items = Item.page(params[:page]).per(10)
  end

  def new
    @item = Item.new
    @genres = Genre.all
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_item_path(@item.id), notice: "商品が正常に登録されました。"
    else
      render 'show'
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    @genres = Genre.all
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_item_path(@item.id), notice: "変更が正常に保存されました。"
    else
      @item = Item.find(params[:id])
      render 'show'
    end
  end

  private

  def item_params
    params.require(:item).permit(:item_image, :name, :description, :genre_id, :price, :is_active)
  end
end