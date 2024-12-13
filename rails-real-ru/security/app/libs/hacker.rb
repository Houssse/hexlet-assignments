# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'
require 'net/http'

class Hacker
  class << self
    BASE_URL = 'https://rails-collective-blog-ru.hexlet.app'

    def hack(email, password)
      uri = URI("#{BASE_URL}/users/sign_up")
      response = Net::HTTP.get_response(uri)

      csrf_token = token(response.body)

      cookies = response['Set-Cookie']

      uri = URI("#{BASE_URL}/users")
      request = Net::HTTP::Post.new(uri.path)
      request['Cookie'] = cookies
      request.set_form_data(
        'authenticity_token' => csrf_token,
        'user[email]' => email,
        'user[password]' => password,
        'user[password_confirmation]' => password
      )

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme == 'https'
      response = http.request(request)
    end

    def token(html)
      doc = Nokogiri::HTML(html)
      csrf_meta = doc.at('meta[name="csrf-token"]')

      csrf_token = csrf_meta['content'] if csrf_meta

      csrf_token
    end
  end
end