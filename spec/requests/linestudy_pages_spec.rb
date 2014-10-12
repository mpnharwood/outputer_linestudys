require 'spec_helper'

describe "LinestudyPages" do
	subject { page }
	
	let(:user) { FactoryGirl.create(:user) }
	before { sign_in user }

	describe "linestudy creation" do
		before { visit root_path }

		describe "with invalid information" do
			it "should not create a linestudy" do
				expect { click_button "Create" }.not_to change(Linestudy, :count)
			end
			describe "error messages" do
				before { click_button "Create" }
				it { should have_content('error') }
			end
		end

		describe "with valid information" do
			before do
				visit root_path
				fill_in "Name",					with: "A line"
				fill_in "Description",			with: "Example Line"
				fill_in "Category",				with: "thing"
				fill_in "Start time",			with: 10.hours.ago
			end
			it "should create a linestudy" do
				expect { click_button "Create" }.to change(Linestudy, :count).by(1)
			end
		end
	end
end
