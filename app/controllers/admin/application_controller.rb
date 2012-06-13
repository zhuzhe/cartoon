class Admin::ApplicationController < ApplicationController
  protect_from_forgery

  USERS = { "zhuzhe" => "zhuzhe@manhua.com" }

  http_basic_authenticate_with :name => "zhuzhe", :password => "zhuzhetoo"
  
   # before_filter :authenticate
  
   private
  
   def authenticate
     authenticate_or_request_with_http_digest do |username|
       USERS[username]
     end
   end
end
