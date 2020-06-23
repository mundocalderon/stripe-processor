class Product < ActiveRecord::Base
  has_many :charges

  validates :name, presence: true
  validates :price, numericality: { greater_than: 0 }
end
