class RenameTypeColumnInStudentsToStudentType < ActiveRecord::Migration
  def up
  	rename_column :students, :type, :student_type
  end

  def down
  	rename_column :students, :student_type, :type
  end
end
