class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.int :user_id
      t.string :url
      t.string :comment
      t.string :type

      t.timestamps null: false
    end
  end
end
