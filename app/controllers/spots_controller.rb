class SpotsController <ApplicationController

  def index
    if session[:sf_hash] && session[:fs_hash]
      @username = session[:sf_hash].extra.username
      respond_to do |format|
        format.html
      end
    else
      flash[:notice] = 'User needs to be logged in to both Salesforce and Foursquare'
      redirect_to :controller => 'users', :action => 'login'
    end
  end
  def show
    if session[:fs_hash]
      id = params[:id]
      if id
        client = Foursquare2::Client.new(:oauth_token => session[:fs_hash].credentials.token) unless client
        @venue = client.venue(id);
        #reach out to foursquare and grab data about specific spot
        respond_to do |format|
          format.html
        end
      end

    end
  end
end