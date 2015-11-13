class EventManagement < ActiveRecord::Base
  validates_uniqueness_of :event_id, scope: [:admin_id]
  belongs_to :event
  belongs_to :admin, :class_name => "User"
end
