class  Api::UsersController < ApiController
	
	def create
		@user=nil
    	logon_success=false
    	@user = User.create(email: params[:email], password: params[:password])

    	if @user.valid?
    		 @user.auth_token = generate_token 
     		 @user.save
     		 http_status_response(status: :ok, message: "User Created", data: @user)
    	else
    		 http_status_response(status: :unprocessable_entity, message: "Invalid User Creation Params", data: @user.errors.full_messages)
    	end

    	
	end

end
