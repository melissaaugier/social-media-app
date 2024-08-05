class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_account_update_params, only: [:update]

  def new
    @registration_form = RegistrationForm.new
  end
  
  def create
    @registration_form = RegistrationForm.new(sign_up_params)
    
    if @registration_form.save
      set_flash_message!(:notice, :signed_up)
      sign_up(resource_name, @registration_form.user)
      redirect_to after_sign_up_path_for(@registration_form.user), status: :see_other
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('registration_form', partial: 'devise/registrations/form', locals: { registration_form: @registration_form })
        end
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  private

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def sign_up_params
    params.require(:registration_form).permit(:name, :last_name, :email, :password, :password_confirmation)
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    super(resource)
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
