class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private
  def sign_up_params
    params.require(:user).permit(
      :email,
      :password,
      :first_name,
      :last_name
    )
  end

  def sign_up(resource_name, resource)
  end

  def respond_with(resource, _opts = {})
    if resource.persisted?
      render json: {
        message: "Používateľ úspešne vytvorený.",
        user: resource.as_json(only: [ :id, :email, :first_name, :last_name, :role ])
      }, status: :created
    else
      render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
