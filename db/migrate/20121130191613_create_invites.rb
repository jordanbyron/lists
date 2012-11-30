class CreateInvites < ActiveRecord::Migration
  def up
    create_table :invites do |t|
      t.belongs_to :list
      t.belongs_to :user
      t.boolean    :email_sent
      t.timestamps
    end
  end

  def down
    drop_table :invites
  end
end
