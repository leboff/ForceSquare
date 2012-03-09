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
  def checkin
    if session[:sf_hash] && session[:fs_hash]
      fsclient = Foursquare2::Client.new(:oauth_token => session[:fs_hash].credentials.token) unless fsclient
      sfclient = Salesforce.new(session[:sf_hash].credentials.token, session[:sf_hash].credentials.instance_url )

      ##error checks needed
      check = fsclient.add_checkin(:venueId => params[:id], :broadcast => 'public,twitter')

      ##construct url
      url = session[:fs_hash].extra.raw_info.canonicalUrl+'/checkin/'+check.id

      ##error checks needed... this should probably all be somewhere else too
      sfclient.checkin(url, params[:name])

      flash[:notice] = 'Successfully checked in'
      redirect_to :controller => 'spots', :action => 'show' , :id=> params[:id]

    end


  end
end
