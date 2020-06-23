class SwapChargeAmountColumns < ActiveRecord::Migration
  def change
    rename_column :charges, :amount, :original_amount
    add_column :charges, :amount_charged, :integer
  end
end
