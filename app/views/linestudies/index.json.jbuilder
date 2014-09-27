json.array!(@linestudies) do |linestudy|
  json.extract! linestudy, :name, :description, :type, :user_id, :start_time, :end_time
  json.url linestudy_url(linestudy, format: :json)
end