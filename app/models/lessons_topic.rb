class LessonsTopic < ApplicationRecord
  belongs_to :lesson, inverse_of: :lessons_topics
  belongs_to :topic, inverse_of: :lessons_topics
end