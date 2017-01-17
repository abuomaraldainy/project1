class Page < ActiveRecord::Base
  
  #some callbacks 
  before_validation :set_default_permalink
  after_save :update_created_at_time_for_subject



  #sexy validations 
  validates :name , :presence => true,
                    :length => {:maximum => 100}


   validates :permalink , :presence =>true,
   						  :length => {:minimum => 2 , :maximum => 100 },
   						  :uniqueness => true

  #this will order all pages by their position
  acts_as_list :scope => :subject  



  #relationships
  belongs_to :subject
  has_many :sections, :dependent => :destroy
  has_and_belongs_to_many :editors, :class_name => "AdminUser"

  #scopes
  scope :sorted, lambda{ order("position ASC") }
  scope :visible, lambda{ where(:visible => true) }

  private 

     def set_default_permalink
        number = Random.rand(1..100)
     	if permalink.blank?
     		self.permalink = "#{position+number}-#{name.parameterize}"
     	end		
     end

     def update_created_at_time_for_subject
     	subject.touch
     end
end
