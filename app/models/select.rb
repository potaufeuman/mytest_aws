class Select < ApplicationRecord
  belongs_to :question
  delegate :answer, to: :question
end
