class ListDecorator < ApplicationDecorator
  decorates :list

  def name
    if list.name[/'s/]
      list.name
    else
      user.name + "'s " + list.name
    end
  end

  def occurs_on
    list.occurs_on.strftime("%A, %B %e, %Y")
  end
end