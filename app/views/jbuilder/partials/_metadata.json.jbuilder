json.metadata do
  json.page models.current_page
  json.per models.limit_value
  json.total_pages models.total_pages
  json.total_count models.total_count
end
