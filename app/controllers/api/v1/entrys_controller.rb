class Api::V1::EntrysController < ApplicationController
  skip_before_action :verify_authenticity_token

  # 記事一覧を日付順に取得
  def index
    @entrys = Rails.cache.read(request.url)
    if @entrys.nil?
      @entrys = Entry.find(:all, :order => 'created_at desc')
      Rails.cache.write(request.url, @entrys, expires_in: 10.minutes)  # １時間で消える。
    end
  end
  
  def update
    @entrys = Entry.find(params[:id])
    @entrys.increment(:view_count)
    if @entrys.save 
      head :ok
    else
      render json: @rankings.errors.full_message, status: :unprocessable_entity
    end
  end
  
  
  def ranking
    @entrys = Rails.cache.read(request.url)
    if @entrys.nil?
      @entrys = Entry.find(:all, :order => 'view_count desc')
      Rails.cache.write(request.url, @entrys, expires_in: 10.minutes)  # １時間で消える。
    end
  end
  
  # サイト毎のRSS一覧を取得する。ほぼ使われない？ 
  def show
      site_id = params[:id]
      @site   = Site.find(:all, :conditions => {:id => site_id}, :order => 'created_at desc')
      source  = @site[0].rss_url 
      #キャッシュから取得
      @entrys = Rails.cache.read(source)
      if @entrys.nil?
        @entrys = Entry.find(:all, :conditions => {:site_id => site_id})
        Rails.cache.write(source, @entrys, expires_in: 10.minutes)  # １時間で消える。
      end

# => RSSを取得してキャッシュにだけ覚えておく。DBには覚えない処理
#    site_id = params[:id]
#    @site   = Site.find(:all, :conditions => {:id => site_id})
#    if @site.empty? 
#       render json: @site.errors.full_message, status: :unprocessable_entity
#    else
#      source  = @site[0].rss_url 
#      @entrys = Rails.cache.read(source)
#      if @entrys.nil?
#        puts('\n\n cache none \n\n')
#        @entrys = Array.new();
#        feeds    = FeedNormalizer::FeedNormalizer.parse(open(source), :force_parser => FeedNormalizer::SimpleRssParser)        
#        feeds.entries.map do | feed |  
#          obj = Entry.new(:site_id => site_id, :title => feed.title.force_encoding('utf-8'), :url => feed.urls[0])
#          @entrys.push(obj)
#        end
#        Rails.cache.write(source, @entrys, expires_in: 1.hour)  # １時間で消える。
#      else
#        puts('\n\n cache exist \n\n')
#      end

# => RSSを取得してDBに格納する処理もあるやつ
#      @entrys = Entry.find(:all, :conditions => {:site_id => site_id})
#      if @entrys.empty? or Time.at(@entrys[0].created_at.to_i).to_date < Date.today
#        source  = @site[0].rss_url 
#        feeds    = FeedNormalizer::FeedNormalizer.parse(open(source), :force_parser => FeedNormalizer::SimpleRssParser)        
#        if !feeds.nil?
#          feeds.entries.map do | feed |  
#            obj = Entry.new(:site_id => site_id, :title => feed.title.force_encoding('utf-8'), :url => feed.urls[0])
#           if !obj.save?
#             render json: @entrys.errors.full_message, status: :unprocessable_entity
#            end
#          end
#        else
#          render json: @entrys.errors.full_message, status: :unprocessable_entity
#        end
#      end
#    end
  end
    
  private 
  def param_times
    if params[:year].nil? or params[:month].nil? or params[:day].nil? 
      nil
    else
      Time.mktime(params[:year], params[:month], params[:day], 00, 00, 00)
    end
  end
end