class Item < ApplicationRecord

  has_one_attached :item_image

  has_many :cart_items  #"dependent: :destroy"の記載は商品の消去動作がないためつけていません
  has_many :order_details
  belongs_to :genre


  validates :name, presence: true, length: {maximum: 100}
  validates :description, presence: true, length: {maximum: 500}
  validates :genre_id, presence: true
  validates :price, presence: true,length: {maximum: 100}
  validates :is_active, presence: true

  def get_item_image(width, height)
    unless item_image.attached?
      file_path = Rails.root.join("app/assets/images/no_image.jpg")
      item_image.attach(io: File.open(file_path), filename: "no_image.jpg", content_type: "image/jpeg")
    end
    item_image.variant(resize_to_limit: [width, height]).processed
  end
end

