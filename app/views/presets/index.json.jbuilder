json.array!(@presets) do |preset|
  json.extract! preset, :id, :brightness, :saturtion, :hue
  json.url preset_url(preset, format: :json)
end
