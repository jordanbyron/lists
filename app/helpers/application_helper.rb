module ApplicationHelper

  def title(page_title, hide_name = false)
    content_for(:title) { page_title }
  end

end
