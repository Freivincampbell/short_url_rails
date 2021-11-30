# frozen_string_literal: true

# Job to update the title of a resource
class UpdateTitleJob < ApplicationJob
  queue_as :default

  def perform(short_url_id)
    if (url = ShortUrl.find(short_url_id))
      response = HTTParty.get(url.full_url)
      html = Nokogiri::HTML.parse(response.body)

      url.update(title: html.title)
    end
  end
end
