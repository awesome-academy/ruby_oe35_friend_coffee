class Product < ApplicationRecord
  belongs_to :category
  has_many :cart_items, dependent: :destroy
  has_one_attached :image

  PRODUCT_ATTRS = %i(category_id name price old_price information image).freeze

  validates :price, presence: true, numericality: true
  validates :information, presence: true,
    length: {maximum: Settings.home.info}

  delegate :name, :image, to: :category, allow_nil: true, prefix: true

  def display_image
    image.variant(resize_to_limit:
      [Settings.product.size_img, Settings.product.size_img]).processed
  end
end
