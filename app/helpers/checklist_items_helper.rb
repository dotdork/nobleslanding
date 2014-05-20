module ChecklistItemsHelper
 
#  def find_links(items)
#  # iterate our items and see if we have any hyperlinks
#    items.each do |item|
#      words = item.name().split(' ')
#      words.each_with_index do |word, i|
#        if word.starts_with?('http')
#          words[i] = link_to word, "#{word}", :target => "_blank"
#        end        
#      end
#      item.name = words.join(' ')   
#      
#      words = item.description().split(' ')
#      words.each_with_index do |word, i|
#        if word.starts_with?('http')
#          words[i] = link_to word, "#{word}", :target => "_blank"
#        end        
#      end
#      item.description = words.join(' ')
#    end
#    items  
#  end
  
  def find_links(items)
    items.each_with_index do |item,i|
      items[i].description = item.description.gsub( %r{http://[^\s<]+} ) do |url|
        if url[/(?:png|jpe?g|gif|svg)$/]
          "<img src='#{url}' />"
        else
          "<a href='#{url}'>#{url}</a>"
        end   
      end
    end
    items
  end
  
  
  
end
