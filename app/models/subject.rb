class Subject < ActiveRecord::Base

  #validations
  validates_presence_of :name 
  validates_length_of :name, :maximum => 100

  acts_as_list

  #relationships
  
  has_many :pages , :dependent => :destroy

  #scopes
  scope :visible, lambda { where(:visible => true) }
  scope :invisible, lambda { where(:visible => false) }
  scope :sorted, lambda { order("subjects.position ASC") }
  scope :newest_first, lambda { order("subjects.created_at DESC") }
  scope :search, lambda {|query|
      where(["name LIKE?","%#{query}%"])
  }

end
