Rails.application.config.middleware.use OmniAuth::Builder do
  opts = {:fields => [:email, :nickname, :name]}
  provider :developer, opts unless Rails.env.production?
  provider :twitter,   ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
  provider :facebook,  ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
  provider :identity,  opts
end
