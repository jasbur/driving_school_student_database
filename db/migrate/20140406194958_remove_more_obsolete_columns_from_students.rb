class RemoveMoreObsoleteColumnsFromStudents < ActiveRecord::Migration
  def up
    remove_column :students, :discount_type
    remove_column :students, :payment_plan_number
  end

  def down
    add_column :students, :discount_type, :string
    add_column :students, :payment_plan_number, :string
  end
end
