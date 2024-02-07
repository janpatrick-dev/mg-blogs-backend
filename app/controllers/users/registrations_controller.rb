# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    super do |resource|
      resource.assign_attributes(all_permitted_params)
      resource.save if custom_params_present?
    end
  end

  private
    def all_permitted_params
      params.require(:user).permit(*devise_parameter_sanitizer.sanitize(:sign_up), :username, :name)
    end

    def custom_params_present?
      params[:user].present? && all_permitted_params.present?
    end
  
    def respond_with(resource, options={})
      if resource.persisted?
        render json: {
          status: { 
            code: 200, 
            message: 'Signed up successfully.', 
            data: resource
          }
        }, status: :ok
      else
        render json: {
          status: {
            message: 'User could not be created successfully.',
            errors: resource.errors.full_messages
          }
        }, status: :unprocessable_entity
      end
    end
end
