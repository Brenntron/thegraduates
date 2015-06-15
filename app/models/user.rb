class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :email, :first_name, :last_name, :bio, presence: true
  validates :first_name, :last_name, length: { minimum: 3 }
  validates :email, format: { with: /.+@.+\..+/, message: "must be an email address" }, uniqueness: true
  validates :linkedin, :url => true
  validates :twitter, :url => true
  validates :password, confirmation: true
  validates :password, :password_confirmation, presence: { on: :create }
end
