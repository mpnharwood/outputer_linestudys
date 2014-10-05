FactoryGirl.define do
	factory :user do
		name     "John Smith"
		email    "jsmith@example.com"
		organization	"A Company"
		password "foobar"
		password_confirmation "foobar"
	end
end