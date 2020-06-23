class AddStripeCustomerIdToCharges < ActiveRecord::Migration
  def change
    add_column :charges, :stripe_customer_id, :string
  end
end
