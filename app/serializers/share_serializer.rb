class ShareSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :company_name
  belongs_to :user
  belongs_to :stock
end
