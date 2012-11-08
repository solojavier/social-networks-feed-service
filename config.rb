TWITTER_CONSUMER_KEY       = '0vBbk1T3o56CaiVO0SSyQw'
TWITTER_CONSUMER_SECRET    = 'XpfYDkLQqHbSfsvR9vYO8shbKIvRhrj2NtZDQ8pkklE'
TWITTER_OAUTH_TOKEN        = '15816851-65t2B8LXmq2SzO9rxjo5xIigXgJLdMXEKUz0Uk5qH'
TWITTER_OAUTH_TOKEN_SECRET = 's8biRpzU3VBHo85vGSck5fyYlmZ0BX5o5AY7giBiU'
FACEBOOK_TOKEN             = 'AAACEdEose0cBAI46RwwRv1SCwSeishBoxhW8TLZCn8dXLPwZCFlVLMtmZBfOfc2gsJja1OzVPZAX5uQsiU7nSGwplXcli7SVugBK6WZA3BAZDZD'

FACEBOOK_HOME_URL = "https://graph.facebook.com/me/home?access_token=#{FACEBOOK_TOKEN}"
FACEBOOK_POST_URL = "https://graph.facebook.com/me/feed?access_token=#{FACEBOOK_TOKEN}"

Twitter.configure do |config|
  config.consumer_key       = TWITTER_CONSUMER_KEY
  config.consumer_secret    = TWITTER_CONSUMER_SECRET
  config.oauth_token        = TWITTER_OAUTH_TOKEN
  config.oauth_token_secret = TWITTER_OAUTH_TOKEN_SECRET
end
