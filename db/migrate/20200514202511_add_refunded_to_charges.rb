class AddRefundedToCharges < ActiveRecord::Migration
  def change
    add_column :charges, :refunded, :boolean
  end
end
