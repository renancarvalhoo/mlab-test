class Dependent < ActiveRecord::Base
  belongs_to :user

  enum parents: {
    mother:       0,
    father:       1,
    cousin:       2,
    syster:       3,
    brother:      4,
  }

  validates_presence_of :name, :allow_blank => false  
  validates_presence_of :parent, :allow_blank => false  
end
