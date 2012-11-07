class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate

  def authenticate
    if Rails.env.production?
      authenticate_or_request_with_http_basic do |username, password|
        username == "jason" && password == "B1gD4y"
      end 
    end
  end
end
