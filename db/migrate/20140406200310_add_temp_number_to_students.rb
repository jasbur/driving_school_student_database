class AddTempNumberToStudents < ActiveRecord::Migration
  
  def change
    add_column :students, :temp_number, :string
  end

end
