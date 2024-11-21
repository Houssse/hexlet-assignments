# frozen_string_literal: true

class AdminPolicy
  def initialize(app)
    @app = app
  end

  def call(env)
    # BEGIN
    request_path = env['PATH_INFO']
    if request_path.start_with?('/admin')
      [403, {}, []]
    else
      @app.call(env)
    end
    # END
  end
end
