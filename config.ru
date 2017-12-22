require 'dashing'
require 'haml'

configure do
  set :auth_token, 'YOUR_AUTH_TOKEN'

  helpers do
    def protected!
		#test ignoring this file before putting creds here
      # Put any authentication code you want in here.
      # This method is run before accessing any resource.
    end
  end
end

map Sinatra::Application.assets_prefix do
  run Sinatra::Application.sprockets
end

run Sinatra::Application
