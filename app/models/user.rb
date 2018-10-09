class User < ApplicationRecord
    before_save {email.downcase!}
    validates :name, presence: true, length: {maximum: Settings.users.length}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: {maximum: Settings.users.max_length},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
    has_secure_password
    validates :password, presence:true, length: {maximum: Settings.users.length }
    def User.digest string
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
      BCrypt::Password.create string, cost: cost
    end
end
