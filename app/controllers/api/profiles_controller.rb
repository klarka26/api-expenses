class Api::ProfilesController < Api::BaseController
  def show
    render json: current_user.as_json(
      only: [:id, :email, :first_name, :last_name]
    )
  end

  def update
    if current_user.update(profile_params)
      render json: current_user
    else
      render json: { errors: current_user.errors.full_messages }, status: :unprocessable_entity
    end
  end


  private

  def profile_params
    params.require(:user).permit(:first_name, :last_name)
  end
end