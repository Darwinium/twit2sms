# -*- coding: utf-8 -*-
class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def profile
    redirect_to new_session_path unless current_user
  end
  
  def create
    
    # TODO Если пользователь уже есть - предлагать авторизацию
    
    @user = User.new(params[:user])
    if @user.save
      @user.follows.create({:twitter=>@user.twitter})
      session[:user_id] = @user.id
      flash[:notice] = "Thank you for signing up! You are now logged in."
      redirect_to root_url
    else
      render :action => 'new'
    end
    
  end
  
end
