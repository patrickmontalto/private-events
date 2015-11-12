class EventInvitation < ActiveRecord::Base
  belongs_to :event
  belongs_to :inviter, :class_name => "User"
  belongs_to :invitee, :class_name => "User"
end
