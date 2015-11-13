class Event < ActiveRecord::Base
  after_create :assign_creator_to_attendees
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
  has_many :managements, :class_name => "EventManagement"
  has_many :admins, :through => :managements

  def Event.past
    Event.where('datetime < ?', Time.now)
  end

  def Event.upcoming
    Event.where('datetime > ?', Time.now)
  end

  def admin_or_creator?(user)
    self.admins.include?(user) || self.creator == user ? true : false
  end

  private

    def assign_creator_to_attendees
      self.invitations.build(inviter_id: self.creator.id, invitee_id: self.creator.id, attending: true).save
    end

end
