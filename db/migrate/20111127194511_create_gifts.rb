class CreateGifts < ActiveRecord::Migration
  def change
    create_table :gifts do |t|
      t.belongs_to :list

      t.string   :name, :null => false
      t.string   :description
      t.float    :price
      t.integer  :order
      t.string   :link
      t.integer  :quantity

      t.timestamps
    end
  end
end
