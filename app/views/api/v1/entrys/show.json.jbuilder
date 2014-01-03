json.cache! ['v1', @entrys], expires_in: 10.seconds do
  json.array!(@entrys) do |entry|
  	json.extract! entry, :id, :site_id, :title, :url
  end
end

#json.array!(@entrys) do |entry|
#  json.extract! entry, :id, :site_id, :title, :url
#end