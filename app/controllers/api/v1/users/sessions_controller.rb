class Api::V1::Users::SessionsController < Devise::SessionsController

    respond_to :json
    
    before_action :authenticate, :only => :destroy
    skip_before_action :verify_authenticity_token

    def create
      resource = User.find_for_database_authentication(email: params[:user][:email])
      return invalid_login_attempt unless resource
      
      if resource.valid_password?(params[:user][:password])
        # TODO implement api key per user
        #resource.set_api_key
        sign_in(:user, resource)
        render json: resource, :token_visible => true
      else
        invalid_login_attempt
      end
    end
    
    def destroy
      #@api_key.destroy unless @api_key.nil?
      sign_out(:user)
      render json: { message: "Signed out successfully" }, status: :ok
    end

    def failure
      return render:json => {:success => false, :errors => ["Login failed."]}, status: :unauthorized
    end
    
    private

      def invalid_login_attempt
        render json: { error: "Unauthorized Access" }, status: :unauthorized
      end
    
end