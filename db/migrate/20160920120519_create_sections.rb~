class CreateSections < ActiveRecord::Migration

  def change
    create_table :sections do |t|
      t.integer "page_id"
      t.string "name", :limit => 40
      t.integer "position"
      t.boolean "visible", :default => false 
      t.string "content_type", :limit => 100
      t.text "content"
      t.timestamps null: false
    end
     add_index("sections","page_id")
  end

end
