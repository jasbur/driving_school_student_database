class ChangeDefaultValueForDiscountAmountInStudentsTo0 < ActiveRecord::Migration
  def up
  	change_column :students, :discount_amount, :decimal, :default => 0
  end

  def down
  	change_column :students, :discount_amount, :decimal, :default => nil
  end
end
