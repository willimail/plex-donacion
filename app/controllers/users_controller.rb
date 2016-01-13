class UsersController < ApplicationController
	before_action :require_admin, only: [:destroy]
  
    def new
      @user = User.new
    end
    
	def create 
	  @user = User.new(user_params) 
	  if @user.save 
	    session[:user_id] = @user.id 
	    flash[:success] = "Usuario creado!"
	    redirect_to '/'
	  else 
	    redirect_to '/signup' 
	  end 
	end  
	def destroy
		if current_user != User.find(params[:id])
	    	User.find(params[:id]).destroy
	    	flash[:success] = "Usuario eliminado satisfactoriamente"
	    	redirect_to '/'
	    else
	    	flash[:danger] = "Usuario autentificado, imposible borrar..."
	    	redirect_to '/'
		end
    end

	private
	  def user_params
	    params.require(:user).permit(:first_name, :last_name, :email, :password)
	  end  
end
