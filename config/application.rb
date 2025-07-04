require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
require "logger"

Bundler.require(*Rails.groups)

module MyEcommerceApi
  class Application < Rails::Application
    config.load_defaults 6.0

    config.i18n.default_locale = :'pt-BR'
    config.i18n.load_path += Dir[Rails.root.join('config/locales/**/*.{rb,yml}')]

    config.autoload_paths += %w["#{config.root}/app/validators"]

    config.api_only = true
  end
end
