class Event < ApplicationRecord
   belongs_to :user

   has_many :owners
   has_many :users, through: :owners

   validates :name, :date, :city, :state, :user_id, presence: true













#------------ custom validator to make sure that only future dates are accepted on event creation-- NEEDS WORK

   # validate :date_in_future
   # def date_in_future
   #    if DateTime.parse(:date) < DateTime.parse(Time.now)
   #        errors.add(:date, "Your event date must be in the future!")
   #    end
   # end
end
