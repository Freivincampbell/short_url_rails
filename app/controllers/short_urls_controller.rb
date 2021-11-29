class ShortUrlsController < ApplicationController

  # Since we're working on an API, we don't have authenticity tokens
  skip_before_action :verify_authenticity_token

  def index
    short_urls = ShortUrl.top_short_url(100)

    render json: { status: 200, urls: short_urls }
  end

  def create
    url = ShortUrl.create(params_url)

    if url.short_code
      render json: { status: 201, url: url }
    else
      render json: { status: :unprocessable_entity, errors: url.errors }
    end
  end

  def show
    if (url = ShortUrl.find_url(params[:id])) && url.increment_click_counts
      return redirect_to url.full_url
    end

    render json: {
      status: 404, errors: 'Not Found'
    }, status: :not_found
  end

  private

  def params_url
    params.require(:short_url).permit(:full_url)
  end

end
