class CreateProducts < ActiveRecord::Migration
  def up
    create_table :products do |t|
      t.string :name
      t.string :size
      t.string :image
      t.string :price

      t.timestamps
    end
  end

  def down
    drop_table :products
  end
end
