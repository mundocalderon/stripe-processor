class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|
      t.integer :product_id
      t.integer :amount
      t.string :stripe_charge_id

      t.timestamps null: false
    end
    add_index :charges, :product_id
  end
end
