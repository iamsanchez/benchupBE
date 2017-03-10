class Api::SessionsController < ApiController
  def create
    @user=nil
    logon_success=false

    @user=User.find_by_email(params[:email].to_s.strip)
    logon_success = @user.valid_password?(params[:password].to_s.strip) if @user

    if logon_success
      @user.last_sign_in_at = @user.current_sign_in_at
      @user.current_sign_in_at = Time.now
      @user.last_sign_in_ip = @user.current_sign_in_ip
      @user.current_sign_in_ip = request.remote_ip
      @user.sign_in_count += 1
      @user.auth_token = generate_token 
      @user.save

      sale_point = @user.sale_points.first

      http_status_response status: :ok, message: "User Autheticated", data: {auth_token: @user.auth_token}
    #elsif @user
    # http_status_response(status: :unauthorized, message: "User authentication failed: wrong password")
    else
      http_status_response status: :not_found, message: "User not found"
    end
  end

  private

  def generate_token
    safe_token = SecureRandom.hex
    safe_token = SecureRandom.hex while User.find_by(auth_token: safe_token)
    return safe_token
  end
end