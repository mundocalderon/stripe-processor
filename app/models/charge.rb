class Charge < ActiveRecord::Base
  belongs_to :product

  before_validation -> { self.original_amount = product.try :price }
  validates :product, presence: true
  validates :original_amount, numericality: { greater_than: 0 }

  before_create :create_stripe_charge

  def create_stripe_charge
    stripe_charge = Stripe::Charge.create amount: original_amount,
                                          currency: 'usd',
                                          customer: stripe_customer_id,
                                          description: product.name

    self.stripe_charge_id = stripe_charge.id
    self.amount_charged = stripe_charge.amount
  end

  def refund
    refund = Stripe::Charge.retrieve(self.stripe_charge_id).refund
    self.amount_charged = -self.amount_charged
    self.refunded = true
  end
end
