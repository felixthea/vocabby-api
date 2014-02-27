class CreateSynonyms < ActiveRecord::Migration
  def change
    create_table :synonyms do |t|
    	t.string :name
    	t.integer :word_id
      t.timestamps
    end
  end
end
