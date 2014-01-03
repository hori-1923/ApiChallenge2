json.array!(@sites) do |sites|
  json.extract! sites, :id, :name, :url, :rss_url
end