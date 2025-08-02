class Submission < ApplicationRecord
  belongs_to :lesson
  belongs_to :enrollment
  # the lesson did not have this association? 
  # it was already here so i just left it
  belongs_to :student
  belongs_to :mentor
end
