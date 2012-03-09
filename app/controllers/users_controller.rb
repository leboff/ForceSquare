class UsersController < ApplicationController
  def login
    @sf = true if session[:sf_hash]
    @fs = true if session[:fs_hash]
    @username = session[:sf_hash].extra.username if session[:sf_hash]
    respond_to do |format|
      format.html
    end
  end
end