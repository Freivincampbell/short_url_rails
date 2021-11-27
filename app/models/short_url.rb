class ShortUrl < ApplicationRecord

  validates_presence_of :full_url
  validates_uniqueness_of :full_url, case_sensitive: true

  validate :validate_full_url

  before_create :short_code

  scope :top_short_url, ->(limit) { order(click_count: :desc).limit(limit).as_json(except: %i[created_at updated_at]) }

  def short_code
    self.shorted_code = ShortUrlsHelper.url_encode(next_id)
  end

  def next_id
    last_id = ShortUrl.last&.id
    return 1 if last_id.nil?

    last_id + 1
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
