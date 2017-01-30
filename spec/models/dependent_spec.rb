# == Schema Information
#
# Table name: dependents
#
#  id         :integer          not null, primary key
#  name       :text
#  parent     :boolean
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Dependent, type: :model do
  context "validation" do 
    it "should fail if the name is not present" do 
      expect(FactoryGirl.build(:dependent, :parent => 0)).to be_invalid 
    end 
 
    it "should fail if the email is blank" do 
      expect(FactoryGirl.build(:dependent, :name => "")).to be_invalid 
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
