class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :account
  validates :type_of_transaction, :amount, :user_id, :account_id, presence: true
  validates :amount, numericality:  { greater_than: 0 }
  validates :type_of_transaction, inclusion: { in: %w(Deposit Withdrawal Fee), message: "You must enter a valid transaction type. Choose from the following; 'Deposit', 'Withdrawal', 'Fee'"}
  scope :processed, -> { where( processed: true) }
  scope :processed_withdrawals, -> { processed.where("type_of_transaction == 'Withdrawal'")}
  scope :processed_deposits, -> { processed.where("type_of_transaction == 'Deposit'")}
  scope :highest_deposit, -> { maximum("amount")}

  def self.types_for_form
    %w[Withdrawal Deposit]
  end

  def process_transaction
    if self.type_of_transaction == "Deposit" && !self.processed
      self.account.update(:balance => account.balance + self.amount)
      self.update(:processed => true)

      "You have successfully deposited #{self.amount}."

    elsif self.type_of_transaction == "Withdrawal" && !self.processed
      self.account.update(:balance => account.balance - self.amount)
      self.update(:processed => true)

      "You have successfully withdrawn #{self.amount}."
    elsif self.type_of_transaction == "Fee" && !self.processed
      self.account.update(:balance => account.balance - self.amount)
      self.update(:processed => true)

      "You have successfully paid the fee of #{self.amount}"
    end
  end

end
