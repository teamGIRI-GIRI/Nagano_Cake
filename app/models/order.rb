class Order < ApplicationRecord
  has_many :order_details
  belongs_to :customer
  
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: {waiting: 0, paied: 1, making: 2, ready_to_ship: 3, shipped: 4}

  validates :postal_code, presence: true, format: { with: /\A\d{7}\z/ }
  validates :address, presence: true
  validates :name, presence: true

  def address_display
    "〒" + postal_code + " " + address + " " + name
  end
end