# Settings specified here will take precedence over those in config/environment.rb

# The production environment is meant for finished, "live" apps.
# Code is not reloaded between requests
config.cache_classes = true

# Use a different logger for distributed setups
# config.logger = SyslogLogger.new

# Full error reports are disabled and caching is turned on
config.action_controller.consider_all_requests_local = false
config.action_controller.perform_caching             = true
#config.action_view.cache_template_loading            = true
# ovenstående skal udkommenteres for at kunne køre rails 2.2.2

# Enable serving of images, stylesheets, and javascripts from an asset server
# config.action_controller.asset_host                  = "http://assets.example.com"

# Disable delivery errors, bad email addresses will be ignored
# config.action_mailer.raise_delivery_errors = false

config.action_mailer.perform_deliveries = true
config.action_mailer.raise_delivery_errors = true
config.action_mailer.default_content_type = "text/html"
config.action_mailer.default_charset = "UTF-8"


ActionMailer::Base.smtp_settings = {
  :address  => "smtp-relay.brightbox.net",
  :port  => 25, 
  :domain  => "brightbox.net"
}

#ActionController::Base.session_options[:session_domain] = '.blogmail.local'
#ActionController::Base.session_options[:session_domain] = '.blogmail.dk'

