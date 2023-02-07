class Stock < ApplicationRecord
  has_many :shares
  has_many :users, through: :shares

  def self.stock_names
    stock_names = Stock.all.collect do |stock|
      stock.company_name
    end
    stock_names
  end

end
