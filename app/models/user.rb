class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, :presence => true, :uniqueness => {:case_sensitive => false}, :allow_blank => false
  validates_presence_of :name, :allow_blank => false

end
