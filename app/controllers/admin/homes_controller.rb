class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  
  def top
    @orders = Order.page(params[:page]).per(3).order(created_at: :desc).limit(10)
  
  end
  
  
end
