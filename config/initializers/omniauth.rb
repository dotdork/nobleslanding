OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_SECRET'], {:client_options => {:ssl => {:verify => false}}}
  provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"], 
    {
      client_options: {:ssl => {:verify => false}},
      #prompt: 'consent'
    }
  provider :google_oauth2, ENV["GOOGLE_NOBLE_ID"], ENV["GOOGLE_NOBLE_SECRET"], 
    {
      name: 'google_refresh',
      client_options: {:ssl => {:verify => false}},
      prompt: 'consent',
      access_type: 'offline',
      login_hint: 'nobleslanding@gmail.com'
    }  
    
end