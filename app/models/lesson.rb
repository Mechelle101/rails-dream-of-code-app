class Lesson < ApplicationRecord
  has_many :lessons_topics, dependant: :destroy, inverse_of: :lesson
  has_many :topics, through: :lessons_topics
  has_many :submissions, dependent: :destroy
  belongs_to :course
end
