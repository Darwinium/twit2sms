# -*- coding: utf-8 -*-
class UsersController < ApplicationController
  
#  before_filter :redirect_to_login, :only => [:phone_confirm, :profile], :unless => :logged_in? 
  before_filter :login_required, :only => [:phone_confirm, :profile]
  
  def new
    @user = User.new
  end
  
  
  # TODO authorization для нуных полеу before_filter
  def profile
    redirect_to new_session_path unless current_user
  end
  
  def phone_confirm
    if params[:phone_code]==current_user.phone_code
      flash[:notice] = "Код верный. Ваш телефон подтвержден."
      current_user.confirm_phone
    else
      flash[:error] = "Код неверный"

    end
    redirect_to profile_path
#    render :action=>'profile'
  end
  
  def create

    # phone = User.prepare_phone(params[:user][:phone])
    # if @user = User.find_by_phone(phone)
      
    # end
    
    @user = User.new(params[:user])
    
    if @user.save

      @user.follow
      # TODO редирект куда надо, если не прошло
      session[:user_id] = @user.id
      flash[:notice] = "Thank you for signing up! You are now logged in."
      redirect_to root_url
    else
      if @user.errors.on(:phone)=='has already been taken'
        # TODO Если пользователь не одтвердил код? Что-то дожно быть в профиле
        session[:phone]=params[:user][:phone]
        session[:twitter]=params[:user][:twitter]
        #      render :action=> 'new', :controller => 'sessions'
        redirect_to login_path
        return
      else
        render :action => 'new'
      end
    end
    
  end
  
end
