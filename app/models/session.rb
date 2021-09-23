# frozen_string_literal: true

# settings for session
class Session < ApplicationRecord
  def self.sweep(time = 1.hour)
    time = time.split.inject { |count, unit| count.to_i.send(unit) } if time.is_a?(String)
    where('updated_at < ? OR created_at < ?', time.ago.to_s(:db), 2.days.ago.to_s(:db)).delete_all
  end
end
