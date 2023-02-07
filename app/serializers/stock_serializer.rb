class StockSerializer < ActiveModel::Serializer
  attributes :id, :company_name, :price, :shares_available
  has_many :shares
end
