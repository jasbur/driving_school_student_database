class AddPaymentDateAndReceiptNumberToPayments < ActiveRecord::Migration
  
  def change
    add_column :payments, :payment_date, :datetime
    add_column :payments, :receipt_number, :string
  end

end
