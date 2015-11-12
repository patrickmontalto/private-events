class CreateEventInvitations < ActiveRecord::Migration
  def change
    create_table :event_invitations do |t|
      t.integer :inviter_id
      t.integer :invitee_id
      t.integer :event_id
      t.boolean :attending

      t.timestamps null: false
    end
  end
end
