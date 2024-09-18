class Genre < ApplicationRecord
  has_many :items   #"dependent: :destroy"の記載はジャンルの消去動作がないためつけていません
end
