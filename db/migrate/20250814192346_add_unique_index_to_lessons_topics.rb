class AddUniqueIndexToLessonsTopics < ActiveRecord::Migration[8.0]
  def change
    add_index :lessons_topics, [:lesson_id, :topic_id],
              unique: true
  end
end
