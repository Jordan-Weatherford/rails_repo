class User < ApplicationRecord
  has_secure_password

  has_many :owners
  has_many :events, through: :owners

  validates :first_name, :last_name, :email, :city, :state, presence: true

end
