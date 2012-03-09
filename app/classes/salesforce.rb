require 'rubygems'
require 'httparty'

class Salesforce
   include HTTParty
   format :json
   def initialize(token, instance)
     @headers =  {'Content-Type' => 'application/x-www-form-urlencoded', 'Authorization' => 'OAuth ' +token }
     @instance = instance
   end

   def checkin(fs, name)
     options ={ :body =>{ :text => "I just checked in to #{name} on Forcesquare! " + fs, },
                :headers =>  @headers }
      resp = self.class.post(@instance+'/services/data/v23.0/chatter/feeds/to/me/feed-items', options)
   end
end