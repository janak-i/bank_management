class AccountSerializer < ActiveModel::Serializer
  attributes :id, :type_of_account, :balance, :user_id
  has_many :transactions
end
