class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :author_id
      t.integer :post_id

      t.index :author_id
      t.index :post_id

      t.timestamps
    end
  end
end
