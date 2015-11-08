class ListsController < ApplicationController
  before_filter :user_required
  before_filter :find_list, only: [:edit, :update, :show, :destroy]
  before_filter :list_creator_required, only: [:edit, :update, :destroy]
  before_filter :list_creator_prevented, only: :show

  def index
    @personal = current_user.lists.active.decorate
    @invited  = current_user.invited_lists.active.decorate
  end

  def new
    @list = List.new(:occurs_on => Date.today + 1.month)
  end

  def create
    @list = current_user.lists.build(list_params)

    if @list.save
      flash[:notice] = "Your list was successfully created"
      redirect_to edit_list_path(@list)
    else
      render :action => :new
    end
  end

  def show
    @list = ListDecorator.decorate(@list)

    @current_user_claimed = @list.gifts.claimed_by(current_user)
    @available            = @list.gifts.available - @current_user_claimed
    @other_claimed        = @list.gifts.not_claimed_by(current_user)

    @available            = GiftDecorator.decorate_collection(@available)
    @current_user_claimed = @current_user_claimed.decorate
    @other_claimed        = @other_claimed.decorate
  end

  def update
    if @list.update_attributes(list_params)
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

  def list_params
    params.require(:list).permit(:name, :occurs_on, :description,
      gifts_attributes: [:id, :name, :link, :price, :quantity, :_destroy],
      invites_attributes: [:id, :name, :email, :user_id, :_destroy])
  end

  def list_creator_required
    if @list.user != current_user
      flash[:error] = "Sorry, but you don't have access to this list!"
      store_location
      redirect_to root_path
    end
  end

  def list_creator_prevented
    if @list.user == current_user
      flash[:error] = "Hey pal no peeking! That would ruin the surprise."
      store_location
      redirect_to root_path
    end
  end
end
