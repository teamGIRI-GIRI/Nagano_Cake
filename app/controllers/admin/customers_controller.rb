class Admin::CustomersController < ApplicationController
before_action :authenticate_admin!

  def show
    @coustomer = Customer.find(params[:id])
  end 

end
