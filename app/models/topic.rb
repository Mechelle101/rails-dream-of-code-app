class Topic < ApplicationRecord
  has_many :lessons_topics, dependant: :destroy, inverse_of: :topic
  has_many :lessons, through: :lessons_topics
end