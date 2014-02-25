class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
    	t.string :name
    	t.integer :user_id
      t.timestamps
    end

    add_index :words, :user_id
  end
end
