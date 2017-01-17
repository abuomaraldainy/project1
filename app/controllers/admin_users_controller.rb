class AdminUsersController < ApplicationController

  layout "admin"
  before_action :confirm_logged_in, :except => [:login, :attempt_login, :logout]
  
  def index
    @admin_users = AdminUser.sorted
  end

  def new
    @admin_user = AdminUser.new()
  end

  def create
    @admin_user = AdminUser.new(admin_users_params)
    if @admin_user.save 
      flash[:notice] = "New Admin user Successfully added"
      redirect_to(:action => "index")
    else
      flash[:notice] = "There was a problem adding new user name"
      render("new")
    end  
  end

  def edit
    @admin_user = AdminUser.find_by_id(params[:id])
  end

  def update
    @admin_user = AdminUser.find_by_id(params[:id])
    if @admin_user.update_attributes(admin_users_params)
      flash[:notice] = "Admin Records Updated Successfully"
      redirect_to(:action => "index")
    else
      render("edit")
    end  
        
  end

  def delete
    @admin_user = AdminUser.find_by_id(params[:id])
  end

  def destroy
    @admin_user = AdminUser.find_by_id(params[:id])
    @des = @admin_user.destroy
    if @admin_user.destroy
      flash[:notice] = "Admin User Delete Successfully"
      redirect_to(:action => "index")
    else
      redirect_to(:action => "index")
    end  
  end

  private 
     def admin_users_params
        return params.require(:admin_user).permit(:first_name, :last_name, :username, :password, :email) 
     end

end
