class Account < ApplicationRecord
  belongs_to :user
  has_many :transactions
  validates :type_of_account, :balance, :user_id, presence: true
  validates :type_of_account, inclusion: { in: %w(Checking Savings Retirement), message: "You must enter a valid account type."}
  validates :balance, numericality: { greater_than_or_equal_to: 0, message: "must be a number and must be greater than or equal to $0"}, on: :create
  # before_validation :load_defaults

  def self.types_for_form
    %w[Checking Savings Retirement]
  end
end
