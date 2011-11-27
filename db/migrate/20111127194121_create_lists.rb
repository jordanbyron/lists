class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.belongs_to :user

      t.string     :name, :null => false
      t.string     :description
      t.date       :occurs_on
      t.boolean    :archived, :default => false, :null => false
      t.boolean    :public,   :default => false, :null => false

      t.timestamps
    end
  end
end
