class User < ApplicationRecord
  attr_accessor :remember_token #変数をもたせている
  before_save { self.email = email.downcase } # メールアドレスは大文字小文字の区別がないので、保存する前に小文字にする
  validates :name, presence: true, length: {maximum: 50} #nameは必須で最大の長さは50文字
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i #有効なメールアドレスの形式を表した正規表現
  validates :email, presence: true, length:{maximum: 255}, # emailは必須で長さの最大値は255
      format: { with: VALID_EMAIL_REGEX }, #許可される形式はVALID_EMAIL_REGEX
      uniqueness: { case_sensitive: false } #大文字と小文字を区別しない
  has_secure_password #authenticateメソッドを使えるようにする
  validates :password, presence: true, length: {minimum: 6, maximum: 128} # passwordは必須で最短6、最長128

  def User.digest(string) #パスワードをハッシュ化するためのメソット
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
               BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def  User.new_token # ランダムなトークンを返す
    SecureRandom.urlsafe_base64
  end

  # 永続セッションのためにユーザーをデータベースに記憶する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  # ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end
end
