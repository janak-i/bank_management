class User < ApplicationRecord
  # belongs_to :bank
  has_many :accounts
  has_many :transactions, through: :accounts
  has_many :shares
  has_many :stocks, through: :shares
  belongs_to :banks, class_name: "User", optional: true
  has_secure_password
  # validates :username, :email, uniqueness: true
  # validates :email, :on =>:create
  # validates_presence_of :street_address, :city, :state, :email, :on => :create
  # validates :password, length: { minimum: 6, message: "must be at least 6 characters long"}
  # validates :zip_code, numericality: {only_integer: true, message: "can only be numbers"}
  # validates :zip_code, length: { is: 5 }
  # validates :first_name, :last_name, format: { with: /\A[a-zA-Z]+\z/,
  #   message: "Only letters allowed" }
  # validates :age, numericality: { greater_than_or_equal_to: 18 }


end

