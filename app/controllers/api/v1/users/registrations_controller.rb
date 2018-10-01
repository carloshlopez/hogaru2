# encoding: utf-8

class Api::V1::Users::RegistrationsController < ApplicationController
# class Users::RegistrationsController < Devise::RegistrationsController
  clear_respond_to  
  respond_to :json

  def create
    begin
      # user = User.new(params[:user])
      user = User.new(permited_params)
      puts "User created from ·$%·$%$·%&·$%&&%"
      if request.headers['HTTP_FRONT_SRC'] and request.headers['HTTP_FRONT_SRC'] == "greatFullApp"
        puts "GREATFULL"
        user.created_from = "GreatFull"
      end
      # puts "Trying to create a user from the API!!!!! con los datos #{params[:user]}"
      if user.save
        # puts "Se creo bien #{user.inspect}"
        render json: user, :token_visible => true, status: :created
      else
        puts "Error creando usuario:  #{user.errors.inspect}"
        render json: user.errors, status: :unprocessable_entity
      end
    rescue Exception => e
      puts "Error creando el usuario: #{e.message}"
    end
  end

  def reset_password
    user = User.find_by_email(params[:user_email])
    if user
      user.reset_password_token 
      user.send_reset_password_instructions
      render json: {:msg => "Te enviamos las instrucciones para reestablecer tu contraseña por correo electrónico"}, status: :ok
    else
       render json: {:msg => "No existe un usuario con ese correo electrónico"}, status: :not_found
    end
  end
  private
    def permited_params
      # puts "!!!!! USER CONFIGURING STRONG PARAMETERS!!!!"
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :country) 
    end

end
