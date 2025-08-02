class Lesson < ApplicationRecord
  # these two allows that lessons can have multiple topics
  has_many :lessons_topics
  has_many :topics, through: :lessons_topics
  belongs_to :course #this association was here
end
