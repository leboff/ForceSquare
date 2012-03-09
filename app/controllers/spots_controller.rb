class SpotsController <ApplicationController

  def index
    if session[:sf_hash] && session[:fs_hash]
      @username = session[:sf_hash].extra.username
      Rails.logger.info session[:fs_hash].to_yaml
      respond_to do |format|
        format.html
      end
    else
      flash[:notice] = 'User needs to be logged in to both Salesforce and Foursquare'
      redirect_to :controller => 'users', :action => 'login'
    end
  end
end