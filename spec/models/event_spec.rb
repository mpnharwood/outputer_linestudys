require 'spec_helper'

describe Event do
	let(:user) { FactoryGirl.create(:user) }
	let!(:linestudy) { FactoryGirl.create(:linestudy, user: user, name: "line 1") }
	before do
		# This code is not idiomatically correct.
		@event = linestudy.events.build(
			event_start: DateTime.new(2013, 10, 29, 10, 35, 0), 
			event_stop: DateTime.new(2013, 10, 29, 14, 05, 0),
			event_description: "Line is running again",
			status: "Running",
			speed: 100,
			js_id: 1,
			linestudy_id: linestudy.id,
			user_id: linestudy.user_id)
	end

	subject { @event }
	it { should respond_to(:event_start) }
	it { should respond_to(:event_stop) }
	it { should respond_to(:event_description) }
	it { should respond_to(:status) }
	it { should respond_to(:speed) }
	it { should respond_to(:js_id) }
	it { should respond_to(:linestudy_id) }
	it { should respond_to(:user_id) }

	it { should be_valid }
	its(:linestudy) { should eq linestudy }

	describe "when linestudy_id is not present" do
		before { @event.linestudy_id = nil }
		it { should_not be_valid }
	end
	describe "when js_id is not present" do
		before { @event.js_id = nil }
		it { should_not be_valid }
	end
	describe "with blank description" do
		before { @event.event_description = " " }
		it { should_not be_valid }
	end
	describe "with description that is too long" do
		before { @event.event_description = "a" * 201 }
		it { should_not be_valid }
	end
	describe "with blank status" do
		before { @event.status = " " }
		it { should_not be_valid }
	end
	describe "with status that is too long" do
		before { @event.status = "a" * 81 }
		it { should_not be_valid }
	end


	describe "with event_start that is a single digit" do
		before { @event.event_start = "3" }
		it { should_not be_valid }
	end
	describe "with event_start that is in the future" do
		before { @event.event_start = "2050-02-31" }
		it { should_not be_valid }
	end
	describe "with event_start that is in the far past" do
		before { @event.event_start = "1850-02-31" }
		it { should_not be_valid }
	end
	describe "with event_start that is a string" do
		before { @event.event_start = "some nonsense" }
		it { should_not be_valid }
	end
	describe "with event_start that is a good date" do
		before do 
			date = "2013-02-28"
			@event.event_start = date
		end
		it { should be_valid }
	end
	describe "with event_stop that is a single digit" do
		before { @event.event_stop = "3" }
		it { should_not be_valid }
	end
	describe "with event_stop that is in the future" do
		before { @event.event_stop = "2050-02-31" }
		it { should_not be_valid }
	end
	describe "with event_stop that is in the far past" do
		before { @event.event_stop = "1850-02-31" }
		it { should_not be_valid }
	end
	describe "with event_stop that is a string" do
		before { @event.event_stop = "some nonsense" }
		it { should_not be_valid }
	end
	describe "with event_stop that is a good date" do
		before do 
			date = "2013-02-28"
			@event.event_stop = date
		end
		it { should be_valid }
	end

	describe "when speed is not present" do
		before { @event.speed = nil }
		it { should_not be_valid }
	end
	describe "with speed that is a string" do
		before { @event.speed = "some nonsense" }
		it { should_not be_valid }
	end
end
