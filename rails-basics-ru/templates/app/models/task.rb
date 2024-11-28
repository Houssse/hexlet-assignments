class Task < ApplicationRecord
  STATUSES = %w[new in_progress completed].freeze

  validates :name, presence: true
  validates :status, presence: true
  validates :creator, presence: true
  validates :completed, inclusion: { in: [true, false] }
end
