class Tasks::GetEntrys
  
  def self.execute
    @sites   = Site.find(:all)
    
    Site.find(:all).each do |site|
      feeds = FeedNormalizer::FeedNormalizer.parse(open(site.rss_url), :force_parser => FeedNormalizer::SimpleRssParser)
      if !feeds.nil?
        # まずは古い　Entry　を消す（２日間保持する）
        Entry.destroy_all("created_at <= '#{Time.mktime(Time.now.year, Time.now.month, Time.now.day - 2, 00, 00, 00)}'")
        feeds.entries.map do | feed |  
          if !feed.urls[0].nil?
            @entry = Entry.find(:all, :conditions => { :title => feed.title.force_encoding('utf-8') })
            if @entry.empty?
              @entry = Entry.new(:site_id => site.id, :title => feed.title.force_encoding('utf-8'), :url => feed.urls[0])
              @entry.save
            else
              puts 'Info exsit title'
            end
          else
            puts 'Error feed.urls nil'
          end
        end
      end
    end
  end
  
end