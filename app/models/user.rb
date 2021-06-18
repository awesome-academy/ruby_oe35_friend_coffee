class User < ApplicationRecord
  has_many :orders, dependent: :destroy

  attr_accessor :remember_token

  before_save :downcase_email

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

  class << self
    def digest string
      min_cost = ActiveModel::SecurePassword.min_cost
      cost = min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update remember_digest: User.digest(remember_token)
  end

  def authenticated? remember_token
    return false unless remember_digest

    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute :remember_digest, nil
  end

  private

  def downcase_email
    email.downcase!
  end
end
