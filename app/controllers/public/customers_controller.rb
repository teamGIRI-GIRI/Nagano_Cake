class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!

  def show
    @customer = current_customer
  end 
  
  def edit
    @customer = current_customer
  end 
  
  def update
    @customer = current_customer
    if @customer.update(customer_params)
       flash[:success] = "登録情報を変更しました。"
       redirect_to customers_show_path
    else
        render "edit"
    end
  end
  
  def withdraw
    @customer = current_customer
    @customer.update(is_active: true)
    reset_session
    
    redirect_to root_path
  end 
  
end
