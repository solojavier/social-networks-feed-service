require 'sinatra'
require 'json'
require 'twitter'
require 'rest-client'
require 'koala'

# Fill with correct values
TWITTER_CONSUMER_KEY       = ''
TWITTER_CONSUMER_SECRET    = ''
TWITTER_OAUTH_TOKEN        = ''
TWITTER_OAUTH_TOKEN_SECRET = ''
FACEBOOK_TOKEN             = ''

FACEBOOK_HOME_URL = "https://graph.facebook.com/me/home?access_token=#{FACEBOOK_TOKEN}"
FACEBOOK_GRAPH    = Koala::Facebook::API.new FACEBOOK_TOKEN

Twitter.configure do |config|
  config.consumer_key       = TWITTER_CONSUMER_KEY
  config.consumer_secret    = TWITTER_CONSUMER_SECRET
  config.oauth_token        = TWITTER_OAUTH_TOKEN
  config.oauth_token_secret = TWITTER_OAUTH_TOKEN_SECRET
end

get '/feed' do
  response        = RestClient.get FACEBOOK_HOME_URL
  parsed_response = JSON.parse(response.body)
  
  facebook_feed   = parsed_response["data"].map do |d|
    "#{d["message"]} | by #{d["from"]["name"]}" 
  end

  twitter_feed = Twitter.home_timeline(count: 10).map do |t| 
    "#{t.text} | by #{t.user.name}"
  end

  {facebook_feed: facebook_feed, twitter_feed: twitter_feed}.to_json
end

post '/feed' do
  FACEBOOK_GRAPH.put_connections("me", "feed", :message => params[:message])
  Twitter.update(params[:message])

  {message: params[:message]}.to_json
end

get '/' do
  {message: "Social Network  service running"}.to_json
end
