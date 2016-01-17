class SessionsController < ApplicationController
    def destroy 
        session[:user_id] = nil 
        redirect_to '/' 
    end
    def create
        
        user = params[:session][:email] + ':' +  params[:session][:password]
        encode = Base64.strict_encode64(user)
        headers = Hash.new
        headers = {
            'Authorization' => 'Basic ' + encode, 
            'X-Plex-Client-Identifier' => "AppId",
            'X-Plex-Product' => "my App Name",
            'X-Plex-Version' => "0.1.0"
        }
        
        url = URI.parse('https://plex.tv/users/sign_in.json')
        @resp = HTTParty.post(url, :headers => headers)
        
        if @resp.code == 401
            flash[:danger] = "Error!!! Usuario o Password Incorrectos..."
	    	redirect_to '/login'
        
        else
            urlplex = URI.parse('https://plex.tv/api/servers')
            @texto = HTTParty.get(urlplex, :headers => {"X-Plex-Token" => @resp["user"]["authentication_token"]})
	    	
	    	if @texto["MediaContainer"]["Server"]["sourceTitle"] != "carlosepc"
                flash[:danger] = "Lo sentimos!!! Su servidor no esta registrado en nuestra base de datos..."
    	    	redirect_to '/login'
	    	else
	    	
                @user = User.find_by_email(params[:session][:email])
                if @user && @user.authenticate(params[:session][:password])
                  session[:user_id] = @user.id
                  redirect_to '/'
                else
                  redirect_to '/login'
                end 
            end
        end
        
    end
    def index
        
    end
    def message
        if session[:statuslogin] == 401
            @title = "Usuario Incorrecto"
            @info = "Por favor revise su usuario, no pudimos autentificarnos!!!"
        else
        
            @info = "Por favor revise el usuario y el password...aass"
        end
    end
end
