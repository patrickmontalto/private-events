class User < ActiveRecord::Base
  has_many :events, :foreign_key => "creator_id"

  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end
