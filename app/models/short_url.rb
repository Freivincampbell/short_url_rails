class ShortUrl < ApplicationRecord

  validates_presence_of :full_url
  validates_uniqueness_of :full_url, case_sensitive: true

  validate :validate_full_url

  before_create :short_code

  scope :top_short_url, ->(limit) { order(click_count: :desc).limit(limit).as_json(except: %i[created_at updated_at]) }

  def short_code
    self.shorted_code = ShortUrlsHelper.url_encode(id.to_i)

    return true if save

    false
  end

  def update_title!
  end
    return 1 if last_id.nil?

  def increment_click_counts
    self.click_count += 1
    save
  end

  def self.find_url(shorted_code)
    find(ShortUrlsHelper.url_decode(shorted_code))
    find(id)
  rescue ActiveRecord::RecordNotFound
    false
  end

  private

  def validate_full_url
    if (full_url =~ URI::DEFAULT_PARSER.make_regexp(%w[http https])).nil?
      errors.add(:full_url, 'Full url is not a valid url')
    end
  end

end
