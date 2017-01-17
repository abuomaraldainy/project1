class AdminUser < ActiveRecord::Base

  
  #validations
  has_secure_password

  EAMIL_REG_EXPRESION = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i

  validates :first_name, :presence => true,
  						 :length => { :maximum => 30}

  validates :last_name, :presence => true,
  						 :length => { :maximum => 40}

  validates :username, :presence => true,
  					   :length => { :within => 8..40},
  					   :uniqueness => true

  validates :email, :presence => true,
  				    :length => { :maximum => 100},
  				    :format => { :with => EAMIL_REG_EXPRESION },
  				    :confirmation => true						 					 
  
  #relationships
  has_and_belongs_to_many :pages
  has_many :section_edits
  has_many :sections, :through => :section_edits

  def name
    first_and_last_name = "#{first_name} #{last_name}"
    return first_and_last_name
  end

  scope :sorted, lambda { 
    #The same as order("admin_users.last_name ASC, admin_users.first_name  ASC") 
    #or just order("last_name ASC, first_name  ASC")
    order("admin_users.last_name ASC").order("admin_users.first_name ASC") 
  }
end
