class ChargesController < ApplicationController
  before_action :set_charge, only: [:show, :edit, :update, :refund]
  before_action :refund_check, only: [:refund]

  rescue_from Stripe::CardError, with: :card_error

  # GET /charges
  # GET /charges.json
  def index
    @charges = Charge.all
  end

  # GET /charges/1
  # GET /charges/1.json
  def show
  end

  # GET /charges/new
  def new
    @charge = Charge.new
  end

  # POST /charges
  # POST /charges.json
  def create
    @charge = Charge.new(charge_params)
    @charge.stripe_customer_id = ENV['FAILING_STRIPE_CUSTOMER_ID']

    respond_to do |format|
      if @charge.save
        format.html { redirect_to @charge, notice: 'Charge was successfully created.' }
        format.json { render :show, status: :created, location: @charge }
      else
        format.html { render :new }
        format.json { render json: @charge.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /charges/1/refund
  def refund 
    @charge.refund unless @charge.refunded

    if @charge.save
      render :show, notice: "Charge was successfuly refunded."
    else
      render @charge, notice: "Oops! Something went wrong with your refund."
    end
  end

  private
    def card_error exception
      #byebug
      redirect_to product_url(@charge.product_id), notice: exception.message
    end


    # Use callbacks to share common setup or constraints between actions.
    def set_charge
      @charge = Charge.find(params[:id])
    end

    def refund_check
      if @charge.refunded
        redirect_to @charge, notice: "Refund already processed"
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def charge_params
      params.require(:charge).permit(:product_id)
    end
end
