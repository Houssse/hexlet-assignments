# frozen_string_literal: true

class Timer
  def initialize(app)
    @app = app
  end

  def call(env)
    start_time = Time.now

    status, headers, response = @app.call(env)

    end_time = Time.now

    elapsed_time = ((end_time - start_time) * 1_000_000).to_i

    headers['X-Runtime-Microseconds'] = elapsed_time.to_s

    [status, headers, response]
  end
end
