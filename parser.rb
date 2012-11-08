class Parser
  class << self

    def create_facebook_item(data)
      message = create_message(data["message"], "link")
      user    = create_user(data["from"]["name"], 'url', 'avatar')
      create_item(message, user, 'facebook')
    end

    def create_twitter_item(tweet)
      message = create_message(tweet.text, 'link')
      user    = create_user(tweet.user.name, 'url', 'avatar')
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
