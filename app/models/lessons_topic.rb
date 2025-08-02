# this is the join table for lessons and topics
class LessonsTopic < ApplicationRecord
  belongs_to :lesson
  belongs_to :topic
end