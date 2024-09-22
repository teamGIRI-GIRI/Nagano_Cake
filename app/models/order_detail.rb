class OrderDetail < ApplicationRecord

  belongs_to :item
  belongs_to :order
  
  enum making_status: {not_statable: 0, waiting_for_pdoduction: 1, making: 2, finished: 3}

end
