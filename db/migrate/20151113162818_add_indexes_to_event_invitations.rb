class AddIndexesToEventInvitations < ActiveRecord::Migration
  def change
    add_index :event_invitations, :inviter_id
    add_index :event_invitations, :invitee_id
    add_index :event_invitations, :event_id
    add_index :event_invitations, [:inviter_id, :invitee_id, :event_id], unique: true, name: :idx_event_invite_unique
  end
end
