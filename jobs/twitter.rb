require 'twitter'
require 'figaro'


#### Get your twitter keys & secrets:
#### https://dev.twitter.com/docs/auth/tokens-devtwittercom
twitter = Twitter::REST::Client.new do |config|
  config.consumer_key = Figaro.env.twitter_consumer_key
  config.consumer_secret = Figaro.env.twitter_consumer_secret
  config.access_token = Figaro.env.twitter_access_token
  config.access_token_secret = Figaro.env.twitter_access_token_secret
end


SCHEDULER.every '10m', :first_in => 0 do |job|
  begin
    tweets = twitter.user_timeline[0..4] #last 5 tweets

    if tweets
      tweets = tweets.map do |tweet|
        { name: tweet.user.name, body: tweet.text, avatar: tweet.user.profile_image_url_https }
      end
      send_event('twitter_mentions', comments: tweets)
    end
  rescue Twitter::Error
    puts "\e[33mFor the twitter widget to work, you need to put in your twitter API keys in the jobs/twitter.rb file.\e[0m"
  end
end

