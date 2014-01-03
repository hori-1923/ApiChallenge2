class Api::V1::SitesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
      @sites = Site.find(:all)
  end
  
  def show
      @sites = Site.find(params[:id])
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