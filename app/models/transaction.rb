class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :account
  validates :type_of_transaction, :amount, :user_id, :account_id, presence: true
  validates :amount, numericality:  { greater_than: 0 }
  enum transaction_type: {
    credit: '1',
    debit: '0'
  }
  scope :processed, -> { where( processed: true) }
end
