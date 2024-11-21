# frozen_string_literal: true

require 'rack'

class Router
  def call(env)
    # BEGIN
    request = Rack::Request.new(env)
    if request.path == '/'
      [200, {}, ['Hello, World!']]
    elsif request.path == '/about'
      [200, {}, ['About page']]
    else
      [404, {}, ['404 Not Found']]
    end
    # END
  end
end
