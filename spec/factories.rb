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
end