class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|

      t.timestamps
      
      t.string :name
      t.string :street_address
      t.string :city
      t.string :state
      t.string :dob
      t.string :phone_1
      t.string :phone_2
    end
  end
end
