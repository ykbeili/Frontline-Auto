# app/controllers/users/registrations_controller.rb
class Users::RegistrationsController < Devise::RegistrationsController
  # Show the extra field on the form
  def new
    build_resource
    resource.dealer_name = params.dig(:user, :dealer_name)
    super
  end

  # Create Dealer + User together
  def create
    ActiveRecord::Base.transaction do
      dealer_name = sign_up_params.delete(:dealer_name).to_s.strip
      raise ActiveRecord::RecordInvalid.new(Dealer.new), "Dealer name can't be blank" if dealer_name.blank?

      dealer = Dealer.create!(name: dealer_name)
      build_resource(sign_up_params.merge(dealer: dealer)) # build Devise user

      resource.save!
      yield resource if block_given?
      sign_up(resource_name, resource)
    end

    respond_with resource, location: after_sign_up_path_for(resource)
  rescue ActiveRecord::RecordInvalid => e
    clean_up_passwords resource
    set_minimum_password_length
    flash.now[:alert] = e.record.errors.full_messages.to_sentence
    # Refill the virtual field so it stays on the form
    resource.dealer_name = params.dig(:user, :dealer_name)
    respond_with resource, status: :unprocessable_entity
  end

  protected

  # Permit our extra param
  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :dealer_name)
  end
end
