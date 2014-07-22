class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|

      t.timestamps
      
      t.integer :student_id
      t.float :amount
    end
  end
end
