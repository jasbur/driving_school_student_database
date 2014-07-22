class ChangeAmountInPaymentsFromFloatToDecimal < ActiveRecord::Migration
  def up
  	change_column :payments, :amount, :decimal
  end

  def down
  	change_column :payments, :amount, :float
  end
end
