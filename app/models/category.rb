class Category < ApplicationRecord
  has_many :products, dependent: :destroy
  has_one_attached :image

  validates :name, presence: true

  def display_image
    image.variant(resize_to_limit:
      [Settings.product.size_img, Settings.product.size_img]).processed
  end
end
