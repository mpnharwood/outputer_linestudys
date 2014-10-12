require 'spec_helper'

describe Linestudy do

	let(:user) { FactoryGirl.create(:user) }
	before { @linestudy = user.linestudies.build(name: "Study 1", 
		description: "Linestudy on line 1 running milk", 
		category: "", user_id: user.id, 
		start_time: DateTime.new(2013, 10, 29, 10, 35, 0), 
		end_time: DateTime.new(2013, 10, 29, 14, 05, 0)) }	

	subject { @linestudy }

	it { should respond_to(:name) }
	it { should respond_to(:description) }
	it { should respond_to(:category) }
	it { should respond_to(:start_time) }
	it { should respond_to(:end_time) }
	it { should respond_to(:user_id) }
	it { should respond_to(:user) }
	it { should respond_to(:events) }
	its(:user) { should eq user }
	it { should be_valid }

	describe "when user_id is not present" do
		before { @linestudy.user_id = nil }
		it { should_not be_valid }
	end
	describe "with blank name" do
		before { @linestudy.name = " " }
		it { should_not be_valid }
	end
	describe "with name that is too long" do
		before { @linestudy.name = "a" * 81 }
		it { should_not be_valid }
	end
	describe "with description that is too long" do
		before { @linestudy.description = "a" * 201 }
		it { should_not be_valid }
	end
	describe "with category that is too long" do
		before { @linestudy.category = "a" * 81 }
		it { should_not be_valid }
	end

	describe "with start_time that is a single digit" do
		before { @linestudy.start_time = "3" }
		it { should_not be_valid }
	end
	describe "with start_time that is in the future" do
		before { @linestudy.start_time = "2050-02-31" }
		it { should_not be_valid }
	end
	describe "with start_time that is in the far past" do
		before { @linestudy.start_time = "1850-02-31" }
		it { should_not be_valid }
	end
	describe "with start_time that is a string" do
		before { @linestudy.start_time = "some nonsense" }
		it { should_not be_valid }
	end
	describe "with start_time that is a good date" do
		before do 
			date = "2013-02-28"
			@linestudy.start_time = date
		end
		it { should be_valid }
	end
	# describe "with end_time that is a single digit" do
	# 	before { @linestudy.end_time = "3" }
	# 	it { should_not be_valid }
	# end
	# describe "with end_time that is in the future" do
	# 	before { @linestudy.end_time = "2050-02-31" }
	# 	it { should_not be_valid }
	# end
	# describe "with end_time that is in the far past" do
	# 	before { @linestudy.end_time = "1850-02-31" }
	# 	it { should_not be_valid }
	# end
	# describe "with end_time that is a string" do
	# 	before { @linestudy.end_time = "some nonsense" }
	# 	it { should_not be_valid }
	# end
	# describe "with end_time that is a good date" do
	# 	before do 
	# 		date = "2013-02-28"
	# 		@linestudy.end_time = date
	# 	end
	# 	it { should be_valid }
	# end

	describe "event associations" do
		before { @linestudy.save }
		let!(:older_event) do
			FactoryGirl.create(:event, linestudy: @linestudy, user: user, created_at: 1.day.ago)
		end
		let!(:newer_event) do
			FactoryGirl.create(:event, linestudy: @linestudy, user: user, created_at: 1.hour.ago)
		end
		it "should have the right events in the right order" do
			expect(@linestudy.events.to_a).to eq [older_event, newer_event]
		end

		it "should destroy associated events" do
			events = @linestudy.events.to_a
			@linestudy.destroy
			expect(events).not_to be_empty
			events.each do |event|
				expect(Event.where(id: event.id)).to be_empty
			end
		end

	end
end