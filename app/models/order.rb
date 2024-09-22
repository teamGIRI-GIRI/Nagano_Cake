class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details

  def address_display
    "〒" + postal_code + " " + address + " " + name
  end
end

