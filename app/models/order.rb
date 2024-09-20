class Order < ApplicationRecord
  enum payment_method: { credit_card: 0, transfer: 1 }

  has_many :order_details
  belongs_to :customer
  
  def address_display
    "〒" + postal_code + " " + address + " " + name
  end
end
