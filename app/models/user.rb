class User < ActiveRecord::Base
  has_many :hosted_events, :class_name => "Event", :foreign_key => "creator_id"
  has_many :sent_invitations, -> { where 'invitee_id != inviter_id'}, 
                                 :class_name => "EventInvitation", :foreign_key => :inviter_id
  has_many :received_invitations, -> { where 'invitee_id != inviter_id'},
                                 :class_name => "EventInvitation", :foreign_key => :invitee_id
  has_many :invited_events, :through => :received_invitations, :source => 'event'
  has_many :attended_events, -> { where event_invitations: {attending: true}},
                            :through => :received_invitations,
                            :source => 'event'
  has_many :pending_events, -> { where event_invitations: {attending: nil}},
                            :through => :received_invitations,
                            :source => 'event'

  def full_name
      "#{self.first_name} #{self.last_name}"
  end

  def upcoming_events
    self.attended_events.where('datetime > ?', Time.now)
  end

  def previous_events
    self.attended_events.where('datetime < ?', Time.now)
  end

  def received_invites
    self.received_invitations.where('inviter_id != ?', self.id)
  end

end
