class CreateTokens < ActiveRecord::Migration
    def change
        create_table :tokens do |t|
            t.integer :sign_id, null: false
            t.string :key, null: false
      
            t.timestamps null: false
        end
    
        add_index :tokens, :sign_id, :unique=>true
        add_index :tokens, :key, :unique=>true
    end
end