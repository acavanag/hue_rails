json.array!(@lights) do |light|
  json.extract! light, :id, :name, :key
  json.url light_url(light, format: :json)
end
