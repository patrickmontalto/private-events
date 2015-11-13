class EventInvitation < ActiveRecord::Base
  validate :inviter_is_event_creator
  validates_uniqueness_of :event_id, scope: [:invitee_id]
  #validates_presence_of :inviter_id, :if => :event_creator?
  belongs_to :event
  belongs_to :inviter, :class_name => "User"
  belongs_to :invitee, :class_name => "User"

  def inviter_is_event_creator
    if self.event.creator == self.inviter
      true
    else
      errors.add(:base, "Only the host can invite guests")
    end
  end
end
