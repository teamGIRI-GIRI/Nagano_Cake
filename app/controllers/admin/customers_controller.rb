class Admin::CustomersController < ApplicationController
  
  def index
    @customers = Customer.all.page(params[:page])
  end 
  
end
