class Product < ApplicationRecord
  belongs_to :category
  has_many :cart_items, dependent: :destroy
  has_many_attached :images

  validates :name_product, presence: true,
    length: {maximim: Settings.product.validation.name_product}
  validates :price, presence: true, numericality: true
  validates :information, presence: true,
    length: {maximum: Settings.product.validation.info}
end
