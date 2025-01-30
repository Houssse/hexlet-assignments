# frozen_string_literal: true

class Article < ApplicationRecord
  # BEGIN
  def last_reading_date
    Rails.cache.fetch(['article_last_reading', id], expires_in: 12.hours) { Time.current }
  end
  # END
end
