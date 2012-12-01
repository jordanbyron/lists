module ApplicationHelper

  def title(page_title, hide_name = false)
    content_for(:title) { page_title }
    content_for(:hide_name) { "true" } if hide_name
  end

  def error_messages_for(object)
    if object.errors.any?
      content_tag(:div, :id => "errorExplanation") do
        content_tag(:h2) { "It looks like something is missing or incorrect" } +
        content_tag(:p) { "Review the form below and make the appropriate changes." } +
        content_tag(:ul) do
          object.errors.full_messages.map do |msg|
            content_tag(:li) { msg }
          end.join("\n").html_safe
        end
      end
    end
  end
end

