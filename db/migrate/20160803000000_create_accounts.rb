class CreateAccounts < ActiveRecord::Migration
    def change
        create_table :accounts do |t|
            t.string :identifier, null: false
            t.string :player_name, null: false
            t.string :password, null: false
            t.string :user_name, null: false
            t.string :player_name, null: false
      
            t.timestamps null: false
        end
    
        add_index :accounts, :identifier, :unique=>true
    end
end