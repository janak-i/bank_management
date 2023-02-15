class Bank < ApplicationRecord
  has_many :users
  belongs_to :loans, class_name: "User", optional: true
  validates :name, presence: true
  # validates :IFSC_code, presence: true, uniqueness: { scope: :bank_id }
  validates :IFSC_code, uniqueness: true
  validates :bank_balance, numericality: { greater_than_or_equal_to: 0, message: "must be a number and must be greater than or equal to $0"}, on: :create
end





