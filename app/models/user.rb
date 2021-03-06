class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token, :reset_token

  before_save :downcase_email
  before_create :create_activation_digest

  USER_PERMIT = %i(name email password password_confirmation).freeze
  PASSWORD_ATTRS = %i(password password_confirmation).freeze

  validates :name, presence: true,
    length: {maximum: Settings.user.validation.name_max}
  VALID_EMAIL_REGEX = Settings.user.format.email
  validates :email, presence: true,
    length: {maximum: Settings.user.validation.email_max},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: true

  has_secure_password

  validates :password, presence: true,
    length: {minimum: Settings.user.validation.pass_min},
    allow_nil: true

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

  def activate
    update activated: true, activated_at: Time.zone.now
  end

  def remember
    self.remember_token = User.new_token
    update remember_digest: User.digest(remember_token)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def authenticated? attribute, token
    digest = send "#{attribute}_digest"
    return false unless digest

    BCrypt::Password.new(digest).is_password? token
  end

  def forget
    update_attribute :remember_digest, nil
  end

  def password_reset_expired?
    reset_send_at < Settings.reset_pass.expired.hours.ago
  end

  private

  def downcase_email
    email.downcase!
  end

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest activation_token
  end
end
