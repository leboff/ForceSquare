class SessionsController < ApplicationController

  def create
    session[:sf_hash] = auth_hash if auth_hash['provider'] == 'salesforce'
    session[:fs_hash] = auth_hash if auth_hash['provider'] == 'foursquare'

    redirect_to :controller => 'users', :action => 'login'
  end

  def failure
    flash[:notice] = params['message']
    redirect_to :controller => 'users', :action => 'login'
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end