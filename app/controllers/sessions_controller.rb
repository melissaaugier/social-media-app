class SessionsController < Devise::SessionsController
    respond_to :html, :turbo_stream

    def create
        super do |resource|
            if resource.persisted?
              # Handle successful sign-in
              respond_with resource, location: after_sign_in_path_for(resource)
            else
              respond_with resource, status: :unprocessable_entity
            end
        end
    end
end