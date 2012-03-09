require 'rubygems'
require 'httparty'

class Salesforce
   include HTTParty
   format :json
   def initialize(token, instance, version)
     @headers = {'Authorization' => "OAuth #{token}", 'Content-Type:' =>"application/json"}
     @instance = instance
     @version = version
   end

   def checkin
      puts @auth
   end
end