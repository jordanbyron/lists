class ListsController < ApplicationController
  before_filter :user_required

  def index
    @lists = ListDecorator.decorate(current_user.lists.active)
  end

end