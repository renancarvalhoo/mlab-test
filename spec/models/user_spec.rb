require 'rails_helper'

 
RSpec.describe User, type: :model do 
  context "validation" do 
    it "should fail if the email is not present" do 
      expect(FactoryGirl.build(:user, :email => nil)).to be_invalid 
    end 
 
    it "should fail if the email is blank" do 
      expect(FactoryGirl.build(:user, :email => "")).to be_invalid 
    end 
 
    it "should fail if the email is not unique" do 
      FactoryGirl.create(:user, :email => "foo@bar.com") 
 
      expect(FactoryGirl.build(:user, :email => "fOo@bar.com")).to be_invalid 
    end 
 
    it "should fail if the username is not unique" do 
      FactoryGirl.create(:user, :email => "foo_bar@email.com") 
 
      expect(FactoryGirl.build(:user, :email => "foO_bAr@email.com")).to be_invalid 
    end 
 
    it "should fail if the name is not present" do 
      expect(FactoryGirl.build(:user, :name => nil)).to be_invalid 
    end 
 
    it "should fail if the name is blank" do 
      expect(FactoryGirl.build(:user, :name => "")).to be_invalid 
    end 
  end 
end

