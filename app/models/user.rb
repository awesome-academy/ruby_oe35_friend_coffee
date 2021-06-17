class User < ApplicationRecord
  has_many :orders, dependent: :destroy

  validates :name, presence: true,
    length: {maximum: Settings.user.validation.name_max}
  VALID_EMAIL_REGEX = Settings.user.format.email
  validates :email, presence: true,
    length: {maximum: Settings.user.validation.email_max},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: true
end
