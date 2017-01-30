# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  provider               :string           default("email"), not null
#  uid                    :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  failed_attempts        :integer          default("0"), not null
#  unlock_token           :string
#  locked_at              :datetime
#  name                   :string
#  nickname               :string
#  image                  :string
#  email                  :string
#  tokens                 :json
#  created_at             :datetime
#  updated_at             :datetime
#

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

