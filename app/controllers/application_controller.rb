class ApplicationController < ActionController::API
  include Swagger::Blocks
  include ExceptionHandling

  before_action :authorize_user!

  def current_user
    @current_user
  end

  private

  def authorize_user!
    token = request.headers[:Authorization]
    @current_user = User.find_by_token(token)
    raise Authentication::Unauthorized if @current_user.blank?
  end
end
