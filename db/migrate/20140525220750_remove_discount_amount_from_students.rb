class RemoveDiscountAmountFromStudents < ActiveRecord::Migration
  def up
      remove_column :students, :discount_amount
  end

  def down
      add_column :students, :discount_amount, :decimal
  end
end
