class TransactionSerializer < ActiveModel::Serializer
  byebug
  attributes :id, :type_of_transaction, :amount, :processed, :account_id

end
