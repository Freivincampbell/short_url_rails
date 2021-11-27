class ShortUrlsController < ApplicationController

  # Since we're working on an API, we don't have authenticity tokens
  skip_before_action :verify_authenticity_token

  def index
    short_urls = ShortUrl.top_short_url(100)

    render json: { status: 200, urls: short_urls }
  end

  def create
    url = ShortUrl.new(params_url)

    if url.save
      render json: { status: 201, url: url }
    else
      render json: { status: 400, errors: url.errors }
    end
  end

  def show
  end

  private

  def params_url
    params.require(:short_url).permit(:full_url)
  end

end
