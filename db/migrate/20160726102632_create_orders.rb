class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :identifier, null: false
      t.string :target_type, null: false
      t.string :section, null: false
      t.string :target_identifier, null: false
      t.string :progress_status, null: false
      t.text :parameters
      t.string :progress_result
      t.string :result_error_code
      t.text :result_detail
      
      t.timestamps null: false
    end
    
    add_index :orders, :identifier, :unique=>true
  end
end
