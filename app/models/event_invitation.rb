class EventInvitation < ActiveRecord::Base
  validate :inviter_is_event_creator_or_admin
  validates_uniqueness_of :event_id, scope: [:invitee_id]
  #validates_presence_of :inviter_id, :if => :event_creator?
  belongs_to :event
  belongs_to :inviter, :class_name => "User"
  belongs_to :invitee, :class_name => "User"

  def inviter_is_event_creator_or_admin
    if self.event.creator == self.inviter
      true
    elsif self.event.admins.include?(self.inviter)
      true
    else
      errors.add(:base, "Only admins or host can invite guests")
    end
  end

  def status
    case self.attending
    when true
      'Accepted'
    when false
      'Declined'
    when nil
      'Pending'
    end
  end
end
