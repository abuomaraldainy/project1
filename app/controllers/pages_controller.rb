class PagesController < ApplicationController

  layout "admin"

  before_action :confirm_logged_in, :except => [:login, :attempt_login, :logout]
  before_action :find_pages_belong_to_subject
  
  
  def index
    @pages = @subject.pages.sorted
  end

  def show
    @page = Page.find_by_id(params[:id])
  end

  def new
    @page = Page.new({:subject_id => @subject.id})
    @page_count = @subject.pages.count.next
    @subjects = Subject.sorted
  end

  def create
    @page = Page.new(form_params)
    if @page.save 
      flash[:notice] = "Page created sucessfully"
      redirect_to(:action => 'show', :id => @page.id, :subject_id => @subject.id )
    else
      @page_count = @subject.pages.count.next
      @subjects = Subject.sorted
      render('new')
    end
  end

  def edit
    @page = Page.find_by_id(params[:id])
    @page_count = @subject.pages.count
    @subjects = Subject.sorted
  end

  def update
    @page = Page.find_by_id(params[:id])
    if @page.update_attributes(form_params)
       flash[:notice] = "Page updated sucessfully"
       redirect_to(:action => 'index', :id => @page.id, :subject_id => @subject.id )
    else
       @page_count = @subject.pages.count
       @subjects = Subject.sorted
       render('edit')
    end
   
  end

  def delete
    @page = Page.find_by_id(params[:id])
  end

  def destroy
    @page = Page.find_by_id(params[:id])
    if @page.destroy
       flash[:notice] = "Page deleted sucessfully"
       redirect_to(:action => 'index' ,:subject_id => @subject.id )
    end
  end

  private 

     def form_params
       params.require(:page).permit(:subject_id, :name, :permalink, :position, :visible)
     end

     def find_pages_belong_to_subject
        if params[:subject_id].present?
          @subject = Subject.find(params[:subject_id])
        end
     end
end
