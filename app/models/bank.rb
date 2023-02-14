class Bank < ApplicationRecord
  has_many :users
  validates :name, presence: true
  validates :name, uniqueness: true
  belongs_to:accounts

end
