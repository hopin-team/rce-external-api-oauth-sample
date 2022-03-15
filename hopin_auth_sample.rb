# frozen_string_literal: true

require 'base64'
require 'erb'
require 'json'
require 'rest-client'
require 'sinatra'

include ERB::Util

use Rack::Session::Pool, expire_after: 10_000

APP_ID       = ENV['HOPIN_APP_ID']
APP_SECRET   = ENV['HOPIN_APP_SECRET']
CALLBACK     = url_encode(ENV['HOPIN_CALLBACK_URL']) # This must match exactly the callback url that hopin has on file for this app.
PLATFORM_URI = ENV.fetch("HOPIN_PLATFORM_DOMAIN", "https://hopin.com/")
API_URI      =  ENV.fetch("HOPIN_API_DOMAIN", "https://api.hopin.com/")
SCOPES       = 'api'
RESOURCE     = url_encode(ENV['HOPIN_RESOURCE_URI'])

get '/' do
  erb :index
end

get '/auth' do
  state = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
  redirect to("#{PLATFORM_URI}/oauth/authorize?&redirect_uri=#{CALLBACK}&client_id=#{APP_ID}&scope=#{SCOPES}&state=#{state}&response_type=code&resource=#{RESOURCE}")
end

get '/auth/hopin/callback' do
  auth_code = params['code']
  csrf_code = params['state'] # You should verify this matches the state we generated in the first stage.
  error     = params['error']
  error_msg = params['error_description']

  if error
    erb :rejected, locals: { error: error, message: error_msg }
  else
    # Exchange our new auth code for an access_token. You'll notice it has a "expires_at" attribute. When this time elapses
    # the access_token will no longer work. You should use the refresh token to get a new pair of refresh/access tokens in that case.
    response = RestClient.post "#{PLATFORM_URI}oauth/token?grant_type=authorization_code&code=#{auth_code}&redirect_uri=#{CALLBACK}&client_id=#{APP_ID}&client_secret=#{APP_SECRET}&resource=#{RESOURCE}", {},
                               { Accept: 'application/json' }
    token_details = JSON.parse(response.body)

    # Use the access token check the healthcheck endpoint.
    response = RestClient.get "#{API_URI}v1/health", { Authorization: bearer_token(token_details['access_token']) }
    api_response = JSON.parse(response.body)

    erb :authed, locals: { api_response: api_response, token_details: token_details }
  end
end

def bearer_token(token)
  "Bearer #{token}"
end
