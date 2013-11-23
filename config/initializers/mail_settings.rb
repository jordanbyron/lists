ActionMailer::Base.smtp_settings = {
  :address              => ENV['SMTP_ADDRESS'],
  :port                 => ENV['SMTP_PORT'] || 587,
  :domain               => ENV['SMTP_DOMAIN'],
  :user_name            => ENV['SMTP_USER'],
  :password             => ENV['SMTP_PASSWORD'],
  :authentication       => ENV['SMTP_AUTH'],
  :enable_starttls_auto => ENV['SMTP_TLS'] == "true"
}
