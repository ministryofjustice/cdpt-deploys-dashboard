class CreateSite < ActiveRecord::Migration[8.0]
  def change
    create_table :sites do |t|
      t.string :name
      t.string :url
      t.string :prefix
      t.datetime :built_at
      t.string :tag
      t.string :commit
      t.timestamps
    end
  end
end
