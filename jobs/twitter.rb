require 'twitter'


#### Get your twitter keys & secrets:
#### https://dev.twitter.com/docs/auth/tokens-devtwittercom
twitter = Twitter::REST::Client.new do |config|
  config.consumer_key = '90zhPqAeH8EfnbDUouJziRbGJ'
  config.consumer_secret = 'MagkmsMqfrpvqCZYxdsOWutTw1ZGxC6vBQcL2iRaW3qPJtORL6'
  config.access_token = '5414162-feK1ujqZUQdeO8sWFjL7CNrgPRAHmPuj9Uw47YB0mM'
  config.access_token_secret = 'oIyUebJSdls5MmV0BQ49TZrzCNCsTNRzwDUNwGM1LW9gE'
end

# search_term = URI::encode('#todayilearned')

SCHEDULER.every '10m', :first_in => 0 do |job|
  begin
#    tweets = twitter.search("#{search_term}")
# instead of searching... get my latest 5 tweets
    tweets = twitter.user_timeline[0..4]

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
