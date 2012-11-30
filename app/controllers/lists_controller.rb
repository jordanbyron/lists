class ListsController < ApplicationController
  before_filter :user_required
  before_filter :find_list, :only => [:edit, :update, :show, :destroy]

  def index
    @personal = ListDecorator.decorate(current_user.lists.active)
    @invited  = ListDecorator.decorate(current_user.invited_lists.active)
  end
  
  def new
    @list = List.new(:occurs_on => Date.today + 1.month)
  end
  
  def create
    @list = current_user.lists.build(params[:list])
    
    if @list.save
      flash[:notice] = "Your list was successfully created"
      redirect_to edit_list_path(@list)
    else
      render :action => :new
    end
  end
  
  def show
    @list = ListDecorator.decorate(@list)
  end
  
  def update
    if @list.update_attributes(params[:list])
      flash[:notice] = "Your list was successfully updated"
      redirect_to edit_list_path(@list)
    else
      render :edit
    end
  end
  
  def destroy
    @list.destroy
    
    flash[:notice] = "Your list was successfully deleted"
    redirect_to lists_path
  end
  private
  
  def find_list
    @list = List.find(params[:id])
  end

end