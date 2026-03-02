class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  def sign_up(resource_name, resource)
    # nerob nič
  end

  def respond_with(resource, _opts = {})
    if resource.persisted?
      render json: { message: "User created successfully." }, status: :created
    else
      render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
    end
  end
end