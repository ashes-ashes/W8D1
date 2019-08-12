class CreatePostSubs < ActiveRecord::Migration[5.2]
  def change
    create_table :post_subs do |t|
      t.integer :sub_id, null: false
      t.integer :post_id, null: false

      t.index :sub_id
      t.index :post_id

      t.timestamps
    end
  end
end
