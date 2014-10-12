class Linestudy < ActiveRecord::Base
	belongs_to :user
	has_many :events, dependent: :destroy

	default_scope -> { order('created_at DESC') }

	validates :name, presence: true, length: { maximum: 80 }
	validates :description, length: { maximum: 200 }
	validates :category, length: { maximum: 80 }
	validates :user_id, presence: true, numericality: {only_integer: true}
	validates :start_time, presence: true
	
	validates_datetime :start_time, :after => lambda { 5.years.ago },
			:after_message => "must be within 5 years", 
			:before => lambda { 1.minute.ago },
			:before_message => "cannot be in the future" 
	# validates_datetime :end_time, :after => lambda { 5.years.ago },
	# 		:after_message => "must be within 5 years", 
	# 		:before => lambda { 1.minute.ago },
	# 		:before_message => "cannot be in the future"
end
