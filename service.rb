require 'rubygems'
require 'sinatra'
require 'json'
require 'twitter'
require 'rest-client'

require_relative 'config'
require_relative 'parser'

FACEBOOK_HOME_URL = "https://graph.facebook.com/me/home?access_token=#{FACEBOOK_TOKEN}"
FACEBOOK_POST_URL = "https://graph.facebook.com/me/feed?access_token=#{FACEBOOK_TOKEN}"

Twitter.configure do |config|
  config.consumer_key       = TWITTER_CONSUMER_KEY
  config.consumer_secret    = TWITTER_CONSUMER_SECRET
  config.oauth_token        = TWITTER_OAUTH_TOKEN
  config.oauth_token_secret = TWITTER_OAUTH_TOKEN_SECRET
end

get '/feed' do
  items = []
  raw_response = RestClient.get FACEBOOK_HOME_URL
  response     = JSON.parse(raw_response.body)

  response["data"].each do |data|
    items << {item: Parser.create_facebook_item(data)} 
  end

  Twitter.home_timeline('count' => 10).each do |tweet| 
    items << {item: Parser.create_twitter_item(tweet)}
  end

  items.to_json
end

post '/feed' do
  RestClient.post FACEBOOK_POST_URL, {'message' => params[:message]}
  Twitter.update(params[:message])

  {'message' => params[:message]}.to_json
end

get '/' do
  erb :index
end
