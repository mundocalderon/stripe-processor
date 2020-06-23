json.extract! charge, :id, :product_id, :amount, :stripe_charge_id, :refunded, :created_at, :updated_at
json.url charge_url(charge, format: :json)
