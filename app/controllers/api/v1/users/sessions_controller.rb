# frozen_string_literal: true
module Api::V1
  class Users::SessionsController < Devise::SessionsController
    include Response
    include ExceptionHandler

    skip_before_action :verify_signed_out_user, only: :destroy

    def create
      parameter_missing?(%w[email password], params)
      resource = User.find_for_database_authentication(email: params[:email])
      if resource.present? && resource.valid_password?(params[:password])
        auth_token = Auth.encode({user: resource.id})
        resource.update_attributes(auth_token: auth_token)
        user = resource.user_to_json
        json_response({ success: true,
                        message: "Loigin sucessfully",
                        data: user })
      else
        invalid_login_attempt
      end
    end

    def destroy
      user = User.find_by(auth_token: request.headers['HTTP_AUTH_TOKEN'])
      if request.headers['HTTP_AUTH_TOKEN'].blank? || user.blank?
        json_response({ success: false,
                        message: "Auth token is invalid or missing",
                        data: {} })
      else
        user.update(auth_token: nil)
        json_response({ success: true,
                        message: "Signout sucessfully",
                        data: {} })
      end
    end

  protected

    def invalid_login_attempt
      warden.custom_failure!
      json_response({ success: false,
                        message: "Invalid Email or password",
                        data: {} })
    end

    def parameter_missing?(check_parameters = [], parameters = {})
      missing_params = []
      missing_params << check_parameters.select { |p| parameters[p].to_s.strip.blank? }
      if missing_params.flatten!.present?
        raise ArgumentError, "Email and Password are required"
      end
    end
  end
end