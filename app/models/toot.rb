class Toot < ApplicationRecord
  belongs_to :author, class_name: 'User', inverse_of: :toots
  has_many :events, as: :subject

  default_scope { order(created_at: :desc) }

  validates_presence_of :body


  after_create  :create_events
  after_destroy :destroy_events

  private
    # Create Event instances for the Toot itself, as well as any mentions that
    # the Toot contains
    def create_events
      # Create the toot Event
      Event.create(user: author, action: 'toot', subject: self)
      # Find any mentions contained in the Toot and create an event for each
      body.scan(/(?:@)(\w+)/) do |handle|
        Event.create(initiator: User.find_by(handle: handle), action: 'mentioned', subject: self)
      end
    end

    def destroy_events
      Event.where(subject: self).delete_all
    end
end
