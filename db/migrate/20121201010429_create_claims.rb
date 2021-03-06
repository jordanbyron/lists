class CreateClaims < ActiveRecord::Migration
  def change
    create_table :claims do |t|
      t.belongs_to :user
      t.belongs_to :gift
      t.boolean    :purchased, :null => false, :default => false
      t.timestamps
    end
  end
end
