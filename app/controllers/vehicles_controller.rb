class VehiclesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_dealer

  def new
    @vehicle = Vehicle.new
  end


  def create
    @vehicle  = @dealer.vehicles.new(vehicle_params)
    ActiveRecord::Base.transaction do
      if @vehicle.save
        redirect_to root_path, notice: "Vehicle “#{@vehicle.make}” created."
      else
        puts @dealer.name
        puts "@dealer"
        Rails.logger.debug @vehicle.errors.full_messages.inspect
        render :new, status: :unprocessable_content
      end
    end
  end

  private

  def set_dealer
    @dealer = current_user.dealers.find(params[:dealer_id])
  end

  def vehicle_params
    params.require(:vehicle).permit(:year, :make, :model, :trim, :vin, :stock_no, :status)
  end
end
