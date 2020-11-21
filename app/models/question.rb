class Question < ApplicationRecord
  belongs_to :subject, inverse_of: :questions
  has_many :answers

  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true
  
  # validates :description, presence: true  
  validates_presence_of :description
  
  #Kaminari Paginate
  paginates_per 20
end
