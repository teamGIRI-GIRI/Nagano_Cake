class Order < ApplicationRecord
  has_many :order_details
  belongs_to :customer

  enum payment_method: { credit_card: 0, transfer: 1 }

  validates :postal_code, presence: true, format: { with: /\A\d{7}\z/ }
  validates :address, presence: true
  validates :name, presence: true

  def address_display
    "〒" + postal_code + " " + address + " " + name
  end
end