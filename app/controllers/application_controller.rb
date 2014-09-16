class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  
  #protect_from_forgery with: :exception
  
  protect_from_forgery with: :null_session

  def permission_denied
    render file: "public/401.html", layout: false, status: :unauthorized
  end
end
