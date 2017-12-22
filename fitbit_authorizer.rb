#!/usr/bin/env ruby

require "fitgem"
require "yaml"

#config = Fitgem::Client.symbolize_keys YAML.load(File.open(".fitbit.yml"))
#client = Fitgem::Client.new config[:oauth]
#request_token = client.request_token

client = Fitbit::Client.new(
  client_id: Settings.fitbit.client_id,
  client_secret: Settings.fitbit.client_secret,
  token: current_user.token,
  refresh_token: current_user.refresh_token,
  expires_at: current_user.expires_at)

p client.activity

puts "Go to http://www.fitbit.com/oauth/authorize?oauth_token=#{request_token.token} and authorize this widget to access your data. You'll receive a PIN code. Copy and paste that PIN below and hit <enter>:"
verifier = gets.chomp

begin
  access_token = client.authorize request_token.token, request_token.secret, { :oauth_verifier => verifier }
rescue Exception => error
  puts "Error: Could not authorize Fitgem::Client with the supplied OAuth verifier."
  exit
end

config[:oauth].merge! :token => access_token.token, :secret => access_token.secret, :user_id => client.user_info["user"]["encodedId"]
File.open(".fitbit.yml", "w") { |file| file.write config.to_yaml }
