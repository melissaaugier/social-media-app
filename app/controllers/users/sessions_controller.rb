class Users::SessionsController < Devise::SessionsController
  def new
    @resource = resource_class.new
  end
  
  def create
    @resource = resource_class.find_for_database_authentication(email: sign_in_params[:email])
    
    if @resource && @resource.valid_password?(sign_in_params[:password])
      set_flash_message!(:notice, :signed_in)
      sign_in(resource_name, @resource)
      respond_to do |format|
        format.turbo_stream { redirect_to after_sign_in_path_for(@resource) }
        format.html { redirect_to after_sign_in_path_for(@resource) }
      end
    else  
      @resource = resource_class.new(sign_in_params)
      @resource.validate
      @resource.errors.delete(:email, 'has already been taken')

      
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('session_form', partial: 'devise/sessions/form', locals: { resource: @resource })
        end
        format.html { render :new }
      end
    end
  end

  private

  def sign_in_params
    params.require(:user).permit(:email, :password, :remember_me)
  end
end

