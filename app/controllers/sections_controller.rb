class SectionsController < ApplicationController
  
  layout "admin"
  before_action :confirm_logged_in, :except => [:login, :attempt_login, :logout]
  before_action :find_sections_belong_to_page
  
  def index
    @sections = @page.sections.sorted
  end

  def show
    @section= Section.find_by_id(params[:id])
  end

  def new
    @section= Section.new(:page_id => @page.id)
    @section_count = @page.sections.count.next
    @pages = Page.sorted
  end
  
  def create 
    @section = Section.new(form_params)
    if @section.save 
       flash[:notice] = "Section created sucessfully"
       redirect_to(:action => 'show', :id => @section.id, :page_id => @page.id)
    else
      @section_count = @page.sections.count.next
      @pages = Page.sorted
      render('new')
       
    end
  end

  def edit
    @section= Section.find_by_id(params[:id])
    @section_count = @page.sections.count
    @pages = Page.sorted
  end

  def update 
    @section= Section.find_by_id(params[:id])
    if @section.update_attributes(form_params)
       flash[:notice] = "Section updated sucessfully"
       redirect_to(:action => 'index', :page_id => @page.id)
    else
      @section_count = @page.sections.count
      @pages = Page.sorted
      render('edit')
    end
  end

  def delete
     @section= Section.find_by_id(params[:id])
  end

  def destroy 
    @section= Section.find_by_id(params[:id])
    if @section.destroy()
       flash[:notice] = "Section deleted sucessfully"
       redirect_to(:action => 'index', :page_id => @page.id)
    end
  end
 
  
  private 

    def form_params
      params.require(:section).permit(:page_id, :name, :position, :visible, :content_type, :content)
    end

    def find_sections_belong_to_page
        if params[:page_id].present?
          @page = Page.find(params[:page_id])
        end
     end
end
