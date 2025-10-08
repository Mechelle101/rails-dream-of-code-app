class RenameUsersRollToRole < ActiveRecord::Migration[8.0]
  def change
    rename_column :users, :roll, :role
  end
end
