# frozen_string_literal: true

# BEGIN
require 'uri'
require 'forwardable'


class Url
  extend Forwardable
  include Comparable

  def initialize(attribute)
    @uri = URI.parse(attribute)

    @hash_key = {}

    str = @uri.query || ""
    str = str.split(/[=&]/)
             .each_slice(2).to_a

    hash = {}

    str.each do |i|
      symbol = i[0].to_sym
      hash[symbol] = i[1]
    end

    @hash_key = hash

    def ==(other)
      @uri.host == other.host && @uri.scheme == other.scheme && @uri.port == other.port
    end
  end

  def_delegators :@uri, :host, :scheme, :port



  def query_params
    @hash_key
  end

  def query_param(key, default = nil)
    @hash_key[key] || default
  end
end
# END