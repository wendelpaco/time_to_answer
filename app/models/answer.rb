class Answer < ApplicationRecord
  belongs_to :question

  #Kaminari Paginate
  paginates_per 10
end
