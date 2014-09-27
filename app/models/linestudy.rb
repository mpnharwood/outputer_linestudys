class Linestudy < ActiveRecord::Base
	belongs_to :user

	validates :name, length: { maximum: 80 }
	validates :description, length: { maximum: 200 }
	validates :description, length: { maximum: 80 }
	validates :user_id, presence: true, numericality: {only_integer: true}
	


end
