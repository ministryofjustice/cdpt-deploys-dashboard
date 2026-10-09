class AddMetadataUrlToSites < ActiveRecord::Migration[8.0]
  def change
    add_column :sites, :metadata_url, :string
  end
end
