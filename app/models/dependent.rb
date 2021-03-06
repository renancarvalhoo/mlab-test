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

class Dependent < ActiveRecord::Base
  belongs_to :user

  enum parent_types: {
    mother:       0,
    father:       1,
    cousin:       2,
    syster:       3,
    brother:      4,
  }


  validates :name, presence: true, allow_blank: false
  validates_presence_of :parent, :allow_blank => false  
end
