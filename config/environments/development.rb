Kassi::Application.configure do
  APP_CONFIG ||= ConfigLoader.load_app_config

  # Settings specified here will take precedence over those in config/environment.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the webserver when you make code changes.
  config.cache_classes = false

  # To autoload MailPreview, uncomment this line
  # (this is a hack which is fixed properly in Rails 4)
  # config.action_view.cache_template_loading = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  config.assets.prefix = "/assets_dev"
  config.action_controller.action_on_unpermitted_parameters = :raise

  config.assets.prefix = "/assets_dev"

	config.active_support.deprecation :log

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = true

  if APP_CONFIG.mail_delivery_method == "sendmail"
    ActionMailer::Base.delivery_method = :sendmail
  elsif APP_CONFIG.mail_delivery_method == "smtp"
    # Enable sending mail from localhost
    ActionMailer::Base.smtp_settings = {
      :address              => APP_CONFIG.smtp_email_address,
      :port                 => APP_CONFIG.smtp_email_port,
      :domain               => APP_CONFIG.smtp_email_domain || 'localhost',
      :user_name            => APP_CONFIG.smtp_email_user_name,
      :password             => APP_CONFIG.smtp_email_password,
      :authentication       => 'plain',
      :enable_starttls_auto => true
    }
  end
end
