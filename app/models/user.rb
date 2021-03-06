class User < ApplicationRecord
    before_save {email.downcase!}
    validates :name, presence: true, length: {maximum: Settings.users.length}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: {maximum: Settings.users.max_length},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
    has_secure_password
    validates :password, presence:true, length: {maximum: Settings.users.length}
    scope :select_user, -> {select :id, :email, :name}
    scope :order_by, -> {order("name DESC")}
    class << self
      def digest string
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
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
      return false if remember_digest.nil?
      BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

    def forget
      update remember_digest: nil
    end
end
