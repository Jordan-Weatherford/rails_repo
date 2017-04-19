class Event < ApplicationRecord
  belongs_to :user

  has_many :owners
  has_many :users, through: :owners

  
end
