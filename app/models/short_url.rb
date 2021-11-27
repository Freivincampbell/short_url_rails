class ShortUrl < ApplicationRecord

  validates_presence_of :full_url
  validates_uniqueness_of :full_url, case_sensitive: true

  validate :validate_full_url

  scope :top_short_url, ->(limit) { order(click_count: :desc).limit(limit).as_json(except: %i[created_at updated_at]) }
  def short_code
  end

  def update_title!
  end

  private

  def validate_full_url
    if (full_url =~ URI::DEFAULT_PARSER.make_regexp(%w[http https])).nil?
      errors.add(:full_url, 'Full url is not a valid url')
    end
  end

end
