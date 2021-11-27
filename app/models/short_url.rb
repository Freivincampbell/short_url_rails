class ShortUrl < ApplicationRecord

  CHARACTERS = [*'0'..'9', *'a'..'z', *'A'..'Z'].freeze

  validate :validate_full_url

  scope :top_short_url, ->(limit) { order(click_count: :desc).limit(limit).as_json(except: %i[created_at updated_at]) }
  def short_code
  end

  def update_title!
  end

  private

  def validate_full_url
  end

end
