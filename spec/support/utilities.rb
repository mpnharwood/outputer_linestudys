include ApplicationHelper

def full_title(page_title)
  base_title = "QuickStudy"
  if page_title.empty?
    base_title
  else
    "#{base_title} | #{page_title}"
  end
end