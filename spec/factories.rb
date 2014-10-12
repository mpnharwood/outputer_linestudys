FactoryGirl.define do
	factory :user do
		sequence(:name)  { |n| "Person #{n}" }
		sequence(:email) { |n| "person_#{n}@example.com"}
		organization	"A Company"
		password "foobar"
		password_confirmation "foobar"

		factory :admin do
			admin true
		end
	end

	factory :linestudy do
		name "Study 1"
		description "Linestudy on line 1 running milk" 
		category "thing"
		start_time DateTime.new(2013, 10, 29, 10, 35, 0)
		end_time DateTime.new(2013, 10, 29, 14, 05, 0)
		user
	end

	factory :event do
		event_start DateTime.new(2012, 8, 29, 22, 35, 0)
		event_stop DateTime.new(2012, 8, 29, 22, 36, 0)
		event_description "event 1 description"
		speed 300
		status "Running"
		sequence(:js_id) { |x| x }
		linestudy
	end 
end