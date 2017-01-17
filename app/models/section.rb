class Section < ActiveRecord::Base

  after_save :update_created_at_time_for_page

  #validations
  validates_presence_of :name
  validates_length_of :name, :maximum => 100

  CONTENT_TYPES = ['text','html']
  validates_inclusion_of :content_type, :in => CONTENT_TYPES, 
  :message => "Content Type must be either \"#{CONTENT_TYPES[0]}\"or \"#{CONTENT_TYPES[1]}\" "
  validates_presence_of :content


  acts_as_list :scope => :page

 
  #relationships
  belongs_to :page
  has_many :section_edits
  has_many :editors, :through => :section_edits, :class_name => "AdminUser"
  
  #scopes
  scope :visible, lambda { where(:visible => true) }
  scope :sorted, lambda { order("sections.position ASC") }
  

  private 

    def update_created_at_time_for_page
      page.touch
    end
end
