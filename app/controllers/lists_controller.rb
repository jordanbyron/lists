class ListsController < ApplicationController
  before_filter :user_required
  before_filter :find_list, :only => [:edit, :update, :show, :destroy]

  def index
    @lists = ListDecorator.decorate(current_user.lists.active)
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
  
  private
  
  def find_list
    @list = List.find(params[:id])
  end

end