class Parser
  class << self

    TWITTER_LINK  = 'https://twitter.com/ruby_gdl/status/266326868138000384'
    TWITTER_USER  = 'http://twitter.com/ruby_gdl'
    
    FACEBOOK_LINK = 'http://www.facebook.com/RubyGdl/posts/174534229354418'
    FACEBOOK_USER = 'http://www.facebook.com/RubyGdl' 
    
    USER_AVATAR   = 'http://icons.iconarchive.com/icons/danleech/simple/512/github-icon.png'

    def create_facebook_item(data)
      message = create_message(data["message"], FACEBOOK_LINK)
      user    = create_user(data["from"]["name"], FACEBOOK_USER, USER_AVATAR)
      create_item(message, user, 'facebook')
    end

    def create_twitter_item(tweet)
      message = create_message(tweet.text, TWITTER_LINK)
      user    = create_user(tweet.user.name, TWITTER_USER, USER_AVATAR)
      create_item(message, user, 'twitter')
    end
    
    private

    def create_item(message, user, network)
      {message: message, user: user, network: network}
    end

    def create_message(text, permalink)
      {text: text, permalink: permalink}
    end

    def create_user(name, url, avatar)
      {name: name, url: url, avatar: avatar}
    end

  end
end
