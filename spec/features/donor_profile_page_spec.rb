require 'spec_helper'
include UserHelper

describe "Profile Page for donor" do

  before(:each) do
    c = FactoryGirl.create(:candidate)
    Campaign.create(candidate: c, start_date: "31/10/2013", end_date: "31/12/2013", total: 0, goal: 12500, current_campaign: true)
    signup_as_donor

  end

  it "should have donators name recent donations and candidates they have nominated" do

    page.should have_content "Candidates You've Nominated"
    page.should have_content "Recent Donations"
    page.should have_content "Candidates You've Nominated"
  end

  it "should let you log out" do

    click_link "Logout"
    page.should have_link "Sign Up!"
  end

  it "should let you return to homepage" do


    page.should have_link "Adopt-a-Coder"
  end

  it "should show copyright" do

    within('footer') { expect(page).to have_content('Copyright') }
  end
end

