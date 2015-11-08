class ListDecorator < ApplicationDecorator
  decorates :list

  # Include the user's name in the list description when:
  # - The name does not include an "'s" IE "Jordan's list"
  # - The list isn't for the current user
  #
  def name
    if !list.name[/'s/] && !list.name[/#{Regexp.escape(user.name)}/i]
      user.name + "'s " + list.name
    else
      list.name
    end
  end

  def occurs_on
    list.occurs_on.strftime("%A, %B %e, %Y")
  end
end
