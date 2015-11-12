class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime :datetime
      t.string :title
      t.string :location

      t.timestamps null: false
    end
  end
end
