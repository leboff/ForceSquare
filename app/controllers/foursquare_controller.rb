class FoursquareController < ApplicationController
  def search
    if session[:sf_hash] && session[:fs_hash]
      client = Foursquare2::Client.new(:oauth_token => session[:fs_hash].credentials.token) unless client
      @venues = client.search_venues(:ll => params[:lat]+','+params[:lon], :query => params[:query]).to_json  if params[:lat] && params[:lon]
      respond_to do |format|
          format.html {render :json => @venues}
      end
    else
      flash[:notice] = 'User needs to be logged in to both Salesforce and Foursquare'
      redirect_to :controller => 'users', :action => 'login'
    end
  end
end
