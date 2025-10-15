class Users::RegistrationsController < Devise::RegistrationsController

  def new
    build_resource({})
    resource.dealer_name = params.dig(:user, :dealer_name)
    respond_with resource 
  end

  def create
    ActiveRecord::Base.transaction do
      dealer_name = sign_up_params.delete(:dealer_name).to_s.strip
      raise ActiveRecord::RecordInvalid.new(Dealer.new), "Dealer name can't be blank" if dealer_name.blank?

      dealer = Dealer.create!(name: dealer_name)
      build_resource(sign_up_params) # build Devise user
      resource.dealers << dealer
      resource.save!
      yield resource if block_given?
      sign_up(resource_name, resource)
    end

    respond_with resource, location: after_sign_up_path_for(resource)
  rescue ActiveRecord::RecordInvalid => e
    clean_up_passwords resource
    set_minimum_password_length
    flash.now[:alert] = e.record.errors.full_messages.to_sentence
    resource.dealer_name = params.dig(:user, :dealer_name)
    respond_with resource, status: :unprocessable_entity
  end

  protected

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :dealer_name)
  end
end
