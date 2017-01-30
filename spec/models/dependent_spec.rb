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
    it "#name?" do 
      expect(FactoryGirl.build(:dependent, :name => nil, :parent => 0)).to be_invalid 
    end 
 
    it "#name blank ?" do 
      expect(FactoryGirl.build(:dependent, :name => "")).to be_invalid 
    end 
 
  
  end 

end
