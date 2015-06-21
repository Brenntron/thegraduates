class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :email, :first_name, :last_name, :bio, presence: true
  validates :first_name, :last_name, length: { minimum: 3 }
  validates :email, format: { with: /.+@.+\..+/, message: "must be an email address" }, uniqueness: true
  validates_format_of :linkedin, with: URI::regexp(%w(http https)), allow_blank: true
  validates_format_of :twitter, with: URI::regexp(%w(http https)), allow_blank: true
  validates :password, confirmation: true
  validates :password, :password_confirmation, presence: { on: :create }
end
