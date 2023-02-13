class User < ApplicationRecord
  # belongs_to :bank
  has_many :accounts
  has_many :transactions, through: :accounts
  has_many :shares
  has_many :stocks, through: :shares
  belongs_to :banks, class_name: "User", optional: true
  has_secure_password
end

