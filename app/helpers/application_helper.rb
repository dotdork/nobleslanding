module ApplicationHelper

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    if params[:sort] == column.to_s
      link_to "#{title} <i class='#{direction == "asc" ? "glyphicon glyphicon-chevron-up" : "glyphicon glyphicon-chevron-down"}'></i>".html_safe, 
        {:sort => column, :direction => direction}, {:class => css_class}
    else
      link_to title, {:sort => column, :direction => direction}, {:class => css_class} 
    end
  end
end
