class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders
  has_many :cart_items
  has_many :addresses

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true, format: { message: "カタカナを入力してください", with: /\A[ァ-ヶー－]+\z/ }
  validates :first_name_kana, presence: true, format: { message: "カタカナを入力してください", with: /\A[ァ-ヶー－]+\z/ }
  validates :postal_code, presence: true, format: {message: "ハイフンは入力しないでください", with: /\A\d{7}\z/ }
  validates :address, presence: true
  validates :tellphone_number, presence: true, format: {message: "ハイフンは入力しないでください", with: /\A\d{10,11}\z/ }
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+.)+[a-z]{2,})\z/i }
  validates :is_active, inclusion: { in: [true, false] }

  def address_display
    "〒" + postal_code + " " + address + " " + last_name + " " + first_name
  end
  
  # def active_for_authentication?
  #   super && (invalid == true)
  # end
  
end

