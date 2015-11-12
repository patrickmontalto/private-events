class User < ActiveRecord::Base
  has_many :hosted_events, :class_name => "Event", :foreign_key => "creator_id"
  has_many :sent_invitations, :class_name => "EventInvitation", :foreign_key => :inviter_id
  has_many :received_invitations, :class_name => "EventInvitation", :foreign_key => :invitee_id
  has_many :invited_events, :through => :received_invitations, :source => :event_id

  def full_name
      "#{self.first_name} #{self.last_name}"
  end

  def attended_events
    self.invited_events.where(attending: true)
  end

  def upcoming_events
    self.attended_events.where('datetime < ?', Time.now)
  end

  def previous_events
    self.attended_events.where('datetime > ?', Time.now)
  end
end
