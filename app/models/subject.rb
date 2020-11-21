class Subject < ApplicationRecord
  has_many :questions

  # validates :description, presence: true 
  validates_presence_of :description
  
  #Kaminari Paginate
  paginates_per 20
end
