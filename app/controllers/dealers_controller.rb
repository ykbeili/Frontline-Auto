class DealersController < ApplicationController
  def index
    @dealers = Dealer.includes(:users, :vehicles).order(:name)
  end
end
