class Share < ApplicationRecord
  belongs_to :stock
  belongs_to :user
  validates :quantity, numericality:  { greater_than: 0 }
end

