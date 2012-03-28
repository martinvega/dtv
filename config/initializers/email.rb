Dtv::Application.config.action_mailer.default_url_options = {
  :host => URL_HOST
}
Dtv::Application.config.action_mailer.raise_delivery_errors = true
Dtv::Application.config.action_mailer.delivery_method = :smtp
Dtv::Application.config.action_mailer.smtp_settings = {
  :address => 'multisat.com.ar',
  :domain => 'multisat.com.ar',
  :port => 25,
  :user_name => 'consulta_web@multisat.com.ar',
  :password => '12345',
  :authentication => :plain
}
