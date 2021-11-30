class AddShortedCodeToShortUrls < ActiveRecord::Migration[6.0]
  def change
    add_column :short_urls, :shorted_code, :string
  end
end
