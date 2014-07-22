class ChangeDobInStudentToDatetime < ActiveRecord::Migration
  def up
  	remove_column :students, :dob
  	add_column :students, :dob, :datetime
  end

  def down
  	remove_column :students, :dob
  	add_column :students, :dob, :string
  end
end
