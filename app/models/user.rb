class User < ApplicationRecord
  has_many :orders, dependent: :destroy

  USER_PERMIT = %i(name email password password_confirmation).freeze

  validates :name, presence: true,
    length: {maximum: Settings.user.validation.name_max}
  VALID_EMAIL_REGEX = Settings.user.format.email
  validates :email, presence: true,
    length: {maximum: Settings.user.validation.email_max},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: true
  has_secure_password

  validates :password, presence: true,
    length: {minimum: Settings.user.validation.pass_min}
end
