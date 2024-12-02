# frozen_string_literal: true

class SetLocaleMiddleware
  def initialize(app)
    @app = app
  end

  # BEGIN
  def call(env)
    request = Rack::Request.new(env)
    locale = request.env['HTTP_ACCEPT_LANGUAGE']&.scan(/^[a-z]{2}/)&.first

    I18n.locale = I18n.available_locales.include?(locale&.to_sym) ? locale : I18n.default_locale

    @app.call(env)
  end
  # END
end
