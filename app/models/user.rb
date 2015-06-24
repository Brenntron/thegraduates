class User < ActiveRecord::Base
  include PgSearch
  pg_search_scope :search_by_full_name, against: [:first_name, :last_name],
    :using => {
      :tsearch => {dictionary: "english"}
    }
  authenticates_with_sorcery!

  validates :email, :first_name, :last_name, :bio, presence: true
  validates :first_name, :last_name, length: { minimum: 3 }
  validates :email, format: { with: /.+@.+\..+/, message: "must be an email address" }, uniqueness: true
  validates_format_of :twitter, with: /^([a-zA-Z](_?[a-zA-Z0-9]+)*_?|_([a-zA-Z0-9]+_?)*)$/, multiline: true, allow_blank: true
  validates :password, confirmation: true
  validates :password, :password_confirmation, presence: { on: :create }

  def self.text_search(query)
    if query.present?
      where("first_name ilike :q or last_name ilike :q", q: "%#{query}")
    else
      all
    end
  end
end
