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

FactoryGirl.define do
  factory :dependent do
    name   { Faker.name }
    parent { Dependent.parent_types.to_a.sample[0] }
    association :user, factory: :user    
  end
end
