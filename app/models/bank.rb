class Bank < ApplicationRecord
  belongs_to :loan, class_name: "User", optional: true
  validates :name, presence: true
  belongs_to :user
  # validates :Aadhaar_card, presence: true, uniqueness
  # validates :Aadhaar_card, presence: true, uniqueness: { scope: :user_id }
  validates :IFSC_code, uniqueness: true
  validates :bank_balance, numericality: { greater_than_or_equal_to: 0, message: "must be a number and must be greater than or equal to $0"}, on: :create
end





