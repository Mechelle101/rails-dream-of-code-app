class AddConstraintsToSubmissions < ActiveRecord::Migration[8.0]
  def change
    change_column_null :submissions, :enrollment_id, false
    change_column_null :submissions, :lesson_id, false
    change_column_null :submissions, :pull_request_url, false

    # referential integrity
    add_foreign_key :submissions, :enrollments
    add_foreign_key :submissions, :lessons
    add_foreign_key :submissions, :mentors
  end
end
