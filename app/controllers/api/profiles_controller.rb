class Api::ProfilesController < Api::BaseController
  # GET podla id
  def show
    render json: current_user.as_json(
      only: [ :id, :email, :first_name, :last_name, :role ]
    )
  end
end
