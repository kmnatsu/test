class CreateSigns < ActiveRecord::Migration
    def change
        create_table :signs do |t|
            t.integer :account_id, null: false
      
            t.timestamps null: false
        end
    
        add_index :signs, :account_id, :unique=>true
    end
end