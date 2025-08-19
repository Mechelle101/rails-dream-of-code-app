class CreateLessonsTopics < ActiveRecord::Migration[8.0]
  def change
    create_table :lessons_topics do |t|
      # these creates the FKs for the lesson and topic tables
      t.references :lesson
      t.references :topic
      t.timestamps
    end
  end
end
