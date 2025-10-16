class DealersController < ApplicationController
  def index
    @dealers = current_user.dealers.order(:name)
  end
end
