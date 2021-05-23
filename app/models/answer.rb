class Answer < ApplicationRecord
  belongs_to :question
  has_one :select, through: :question
end
