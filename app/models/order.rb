class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details
  
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: {waiting: 0, paied: 1, making: 2, ready_to_ship: 3, shipped: 4}
  
  def address_display
    "〒" + postal_code + " " + address + " " + name
  end
end

