class CreateEventManagements < ActiveRecord::Migration
  def change
    create_table :event_managements do |t|
      t.integer :event_id
      t.integer :admin_id
      
      t.timestamps null: false
    end
  end
end
