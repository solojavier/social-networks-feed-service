TWITTER_CONSUMER_KEY       = ''
TWITTER_CONSUMER_SECRET    = ''
TWITTER_OAUTH_TOKEN        = ''
TWITTER_OAUTH_TOKEN_SECRET = ''
FACEBOOK_TOKEN             = ''

FACEBOOK_HOME_URL = "https://graph.facebook.com/me/home?access_token=#{FACEBOOK_TOKEN}"
FACEBOOK_POST_URL = "https://graph.facebook.com/me/feed?access_token=#{FACEBOOK_TOKEN}"

Twitter.configure do |config|
  config.consumer_key       = TWITTER_CONSUMER_KEY
  config.consumer_secret    = TWITTER_CONSUMER_SECRET
  config.oauth_token        = TWITTER_OAUTH_TOKEN
  config.oauth_token_secret = TWITTER_OAUTH_TOKEN_SECRET
end
