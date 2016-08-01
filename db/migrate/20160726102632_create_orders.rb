class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :identifier, null: false
      t.string :trget_type, null: false
      t.string :section, null: false
      t.string :target_identifier, null: false
      t.string :progress_status, null: false
      t.string :parameters
      t.string :progress_result
      t.string :result_error_code
      t.string :result_detail
      
      t.timestamps null: false
    end
  end
end
