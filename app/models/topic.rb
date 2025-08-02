class Topic < ApplicationRecord
  has_many :lessons_topics #connects to the join table
  has_many :lessons, through: :lessons_topics #creates the m-to-m link
end