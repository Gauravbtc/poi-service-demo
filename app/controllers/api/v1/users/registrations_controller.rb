# frozen_string_literal: true
module Api::V1
  class Users::RegistrationsController < Devise::RegistrationsController
    include Response
    include ExceptionHandler

    def create
      parameter_missing?(%w[email password password_confirmation], user_params)
      user = User.new(user_params)
      if user.save
        json_response({ success: true,
                        message: I18n.t("users.registration_done"),
                        data: user })
      else
        warden.custom_failure!
        json_response({ success: false,
                        message: I18n.t("users.errors", msg: "Registration"),
                        data: user.errors })
      end
    end

    private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end

    def parameter_missing?(check_parameters = [], parameters = {})
      missing_params = []
      missing_params << check_parameters.select { |p| parameters[p].to_s.strip.blank? }
      if missing_params.flatten!.present?
        raise ArgumentError, I18n.t("users.registration_required_fields")
      end
    end
  end
end