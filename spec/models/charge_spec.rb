require 'rails_helper'

RSpec.describe Charge, type: :model do
  let(:product) { Product.create(name: 'Sweater', price: 2000) }

  # use many "describe" blocks to describe different test scenarios
  describe 'simple case' do
    # set up the objects you need inside this "describe" block
    # within any "it" block, you can just call "charge" to get
    # the Charge object being set up here
    let!(:charge) { Charge.new(product_id: product.id, stripe_customer_id: ENV['STRIPE_CUSTOMER_ID']) }

    # if you need to run code before each test, put it in one of these:
    before(:each) do
      # run code before each test here
    end

    # this is a test. it's common to have multiple of them within
    # a describe block, so you can test for multiple things
    it 'saves successfully' do
      expect(charge.save).to eq true
    end

    it 'sets charge.stripe_charge_id' do
      charge.save
      expect(charge.stripe_charge_id).not_to eq nil
    end

    it 'refunds successfully' do
      charge.save!
      amount_refunded = -charge.amount_charged
      charge.refund
      expect(charge.amount_charged).to eq(amount_refunded)
    end
  end
end
