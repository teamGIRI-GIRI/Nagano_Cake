class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!

  def index
    @address = Address.new
    @addresses = current_customer.addresses
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
      flash[:success] = "配送先の登録が完了しました"
      redirect_to addresses_path
    else
      # Rails.logger.error @address.errors.full_messages.join(", ") # エラーメッセージをログに出力
      @addresses = current_customer.addresses
      render :index
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      @addresses = current_customer.addresses
      flash[:success] = "配送先の編集が完了しました"
      redirect_to addresses_path
    else
      @addresses = current_customer.addresses
      render :index
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    @addresses = current_customer.addresses
    redirect_to addresses_path
  end

  private
  #ストロングパラメータ
  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end

end
