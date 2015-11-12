class Event < ActiveRecord::Base
  belongs_to :creator, :class_name => "User"
  has_many :invitations, :class_name => "EventInvitation"
  has_many :invitees, :through => :invitations
  has_many :pending_invitees, -> { where event_invitations: {attending: nil }},
                                  :through => :invitations,
                                  source: :invitee
  has_many :attendees, -> { where event_invitations: {attending: true} },
                          :through => :invitations,
                          source: :invitee
  has_many :absentees, -> { where event_invitations: {attending: false} },
                          :through => :invitations,
                          source: :invitee

  def Event.past
    Event.where('datetime < ?', Time.now)
  end

  def Event.upcoming
    Event.where('datetime > ?', Time.now)
  end

end
