class DealersController < ApplicationController
  before_action :authorize_owner!, only: [:new]


  def index
    @dealers = current_user.dealers.order(:name)
  end

  def new
    @dealer = Dealer.new
  end

  def create
    @dealer = Dealer.new(dealer_params)

    ActiveRecord::Base.transaction do
      if @dealer.save
        current_user.dealers << @dealer
        redirect_to root_path, notice: "Dealer “#{@dealer.name}” created."
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  private

  def dealer_params
    params.require(:dealer).permit(:name)
  end

  def authorize_owner!
    unless current_user.owner?
      redirect_to root_path, alert: "You can't create a dealer"
    end
  end
end
