# Social Networks Service

This lets you post to both your facebook and twitter and gives you a feed of both services in the same place

This is pretty basic and is intended for the purpose of teaching a ruby example in an introductory course

The idea is that you can colaborate to improve this service and learn actually using ruby

# How to make it work

### Facebook

* Go to this site to obtain the token:  https://developers.facebook.com/tools/explorer
* Login to facebook (If you haven't)
* Click on "Get Access Token"
* Assign "publish_actions" on User Data Permissions
* Assign "publish_stream" and "read_stream" on Extender Permissions
* Create token and copy it into config.rb file
* WARNING: Token seems to expire after some time, so you need to generate a new one if connection is not working

### Twitter

* Go to this site to create a new app  : https://dev.twitter.com/apps/new
* Fill the requested values (Be sure to assign read and write persmission to it)
* Generate token
* Copy required values into config.rb file

Open a new terminal and go the the root of the project directory

Run the following commands to setup the enviroment:
* "gem install bundler"
* "bundle install"

To actually run the service use this command:

* "bundle exec ruby service.rb"

Go to [http://localhost:4567](http://localhost:4567) and have fun

# What is next?

If you want to improve your skills and learn more about Ruby, implement one of the following missing features

* Remove hardcoded values in Parser class (TWITTER_LINK, TWITTER_USER, USER_AVATAR...) by obtaining the values from data response from social networks
* Add logic so you can select in which social network you want to post a message
* Implement a service to configure authentication programatically
* Order posts by date (when mixed both streams)
* Add the ability to have only one social network working, depending on what configuration values you setup
* Improve the project by doing some tests, writting or correcting documentation or a brand new feature

When you are done, send a [pull request](https://help.github.com/articles/using-pull-requests)

# References

* Rest-Client : https://github.com/archiloque/rest-client
* Twitter gem : https://github.com/sferik/twitter
* Sinatra     : http://www.sinatrarb.com/
* Jquery      : http://jquery.com/
