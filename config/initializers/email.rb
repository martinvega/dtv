Dtv::Application.config.action_mailer.default_url_options = {
  :host => URL_HOST
}
Dtv::Application.config.action_mailer.raise_delivery_errors = true
Dtv::Application.config.action_mailer.delivery_method = :smtp
Dtv::Application.config.action_mailer.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => '23.21.68.171',
  :user_name            => 'martin.vega7',
  :password             => APP_CONFIG['smtp_password'],
  :authentication       => 'plain',
  :enable_starttls_auto => true  
}