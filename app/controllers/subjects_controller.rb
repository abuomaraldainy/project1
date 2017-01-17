class SubjectsController < ApplicationController
  
  layout "admin"
  before_action :confirm_logged_in, :except => [:login, :attempt_login, :logout]
   
  def index
    @subjects = Subject.sorted
  end

  def show
    @subject= Subject.find_by_id(params[:id])
  end

  def new
    @subject= Subject.new()
    @subject_count = Subject.count.next
  end
  
  def create 
    @subject = Subject.new(form_params)
    if @subject.save 
       flash[:notice] = "Subject created sucessfully"
       redirect_to(:action => 'show', :id => @subject.id)
    else
      @subject_count = Subject.count.next
      render('new')  
    end
  end

  def edit
    @subject= Subject.find_by_id(params[:id])
    @subject_count = Subject.count
  end

  def update 
    @subject= Subject.find_by_id(params[:id])
    if @subject.update_attributes(form_params)
       flash[:notice] = "Subject updated sucessfully"
       redirect_to(:action => 'index')
    else
      @subject_count = Subject.count
      render('edit')
    end
  end

  def delete
     @subject= Subject.find_by_id(params[:id])
  end

  def destroy 
    @subject= Subject.find_by_id(params[:id])
    if @subject.destroy()
       flash[:notice] = "Subject deleted sucessfully"
       redirect_to(:action => 'index')
    end
  end
  
  def cancel
    redirect_to(:action => 'index')
  end
  
  private 

    def form_params
      params.require(:subject).permit(:name, :position, :visible)
    end

    def allow_search
      params.require(:search).permit(:name)
    end

end
