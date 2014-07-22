class RemoveDateIssuedColumnFromStudents < ActiveRecord::Migration
  def up
    remove_column :students, :date_issued
  end

  def down
    add_column :students, :date_issued, :datetime
  end
end
