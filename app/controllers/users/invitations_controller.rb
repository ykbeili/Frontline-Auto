class Users::InvitationsController < Devise::InvitationsController
  # before_action :authenticate_user!, except: [:edit, :update]
  before_action :set_dealer, only: [:new, :create]
  before_action :ensure_owner!, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    redirect_to root_path, alert: "Invitation Was Sent"
  end

  private

  def invite_params
    params.require(:user).permit(:email, :name, :role)
  end

  def set_dealer
    puts params
    puts "params"
    @dealer = current_user.dealers.find(params[:dealer_id])
  end

  def ensure_owner!
    redirect_to dealers_path, alert: "Only owners can invite users." unless current_user.owner?
  end
end
