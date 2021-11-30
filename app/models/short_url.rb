# frozen_string_literal: true

# Short Url model
class ShortUrl < ApplicationRecord

  validates_presence_of :full_url
  validates_uniqueness_of :full_url, case_sensitive: true

  validate :validate_full_url

  # find top 100 most popular urls
  scope :top_short_url, ->(limit) { order(click_count: :desc).limit(limit).as_json(except: %i[created_at updated_at]) }

  # Method to generate shorted code
  def short_code
    self.shorted_code = ShortUrlsHelper.url_encode(id.to_i)

    if save
      update_title!
      return true
    end

    false
  end

  # Method to update title with a Job in background
  def update_title!
    UpdateTitleJob.perform_later id
  end

  # Method to increment click count after a shorted code is visited
  def increment_click_counts
    self.click_count += 1
    save
  end

  private

  # Method to validate full url http or https
  def validate_full_url
    return if full_url.nil?

    is_valid_url = (full_url =~ URI::DEFAULT_PARSER.make_regexp(%w[http https]))

    errors.add(:full_url, 'is not a valid url') if is_valid_url.nil?
  end

end
