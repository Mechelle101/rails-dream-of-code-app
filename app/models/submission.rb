class Submission < ApplicationRecord
  belongs_to :lesson
  belongs_to :enrollment
  belongs_to :mentor
  validates :pull_request_url, presence: true
end
