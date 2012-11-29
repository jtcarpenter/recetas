class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  # removed :registerable,
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  validates :name, :presence => true

  # Setup accessible (or protected) attributes for your model
  attr_accessible :admin, :email, :password, :password_confirmation, :remember_me, :name, :posts, :comments
end
