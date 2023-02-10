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
  # validates :type_of_transaction, inclusion: { in: %w(Deposit Withdrawal Fee), message: "You must enter a valid transaction type. Choose from the following; 'Deposit', 'Withdrawal', 'Fee'"}
  # scope :processed, -> { where( processed: true) }
  # scope :processed_withdrawals, -> { processed.where("type_of_transaction == 'Withdrawal'")}
  # scope :processed_deposits, -> { processed.where("type_of_transaction == 'Deposit'")}
  # scope :highest_deposit, -> { maximum("amount")}

  # def self.types_for_form
  #   %w[Withdrawalwithdraw Deposit]
  # end

  def process_transaction
    byebug
    if self.transaction_type == "credit" && !self.processed
      self.account.update(:balance => account.balance + self.amount)
      self.update(:processed => true)

      "You have successfully credited #{self.amount}."

    elsif self.transaction_type == "debit" && !self.processed
      self.account.update(:balance => account.balance - self.amount)
      self.update(:processed => true)

      "You have successfully debited #{self.amount}."
    end
  end
end


