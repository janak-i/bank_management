class UserSerializer < ActiveModel::Serializer
  attributes :id
  has_many :shares, serializer: SimpleShareSerializer
end
