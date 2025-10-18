class UsersController < ApplicationController
  before_action :set_dealer

  def new
    @user = User.new
  end

  def create

  end

  private

  def set_dealer
    @dealer = Dealer.find(params[:dealer_id])
  end

end
