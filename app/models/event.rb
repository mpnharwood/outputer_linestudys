class Event < ActiveRecord::Base
	belongs_to :linestudy
	belongs_to :user
	
	default_scope -> { order('created_at ASC') }
	
	validates :linestudy_id, presence: true, numericality: {only_integer: true}

	validates :user_id, presence: true, numericality: {only_integer: true}
	validates :event_start, presence: true
	validates :event_stop, presence: true
	validates :event_description, length: { maximum: 200 } 
	validates :status, length: { maximum: 80 }
	validates :speed, presence: true, numericality: {greater_than_or_equal_to: 0.0}
	validates :js_id, presence: true, numericality: {only_integer: true}
	
	validates_datetime :event_start, :after => lambda { 5.years.ago },
			:after_message => "must be within 5 years", 
			:before => lambda { 1.minute.ago },
			:before_message => "cannot be in the future"
	validates_datetime :event_stop, :after => lambda { 5.years.ago },
			:after_message => "must be within 5 years", 
			:before => lambda { 1.minute.ago },
			:before_message => "cannot be in the future"
	


	def duration
		((self.event_stop - self.event_start)/60).round(2)
	end

end
