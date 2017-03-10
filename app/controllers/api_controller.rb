class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  respond_to :json

  private


  def verify_user_token
    http_status_response(status: :unauthorized, message: "Bad or missing User Auth token") and return if !params.has_key? :auth_token or !@current_user = User.find_by_auth_token(params[:auth_token])
  end

  def http_status_response(status: nil, message: "", data: nil)
    unless @performed
      response_hash = {status: status, message: message}
      response_hash[:data] = data unless data.nil?
      @performed = true
      render json: response_hash.to_json, status: status and return 
    end
  end

  def paginate
    if params.has_key? :page and params.has_key? :per_page
      @response_data = @response_data.paginate(page: params[:page], per_page: params[:per_page])
    end
  end

  def generate_token
    safe_token = SecureRandom.hex
    safe_token = SecureRandom.hex while User.find_by(auth_token: safe_token)
    return safe_token
  end




end