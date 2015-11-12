class AddMessageToEventInvitations < ActiveRecord::Migration
  def change
    add_column :event_invitations, :message, :string, :default => "You're invited to this event!"
  end
end
