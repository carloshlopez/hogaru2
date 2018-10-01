class Api::V1::AnnouncementsController < ApplicationController
  respond_to :json
  #before_action :authenticate, :only => [:create, :edit]
  before_action :set_user, :only => [:create, :index, :mark_as_seen]
  before_action :set_announcement, :only => [:mark_as_seen]
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  rescue_from Exception, :with => :handle_exception
  skip_before_action :verify_authenticity_token

      
  def index
    #respond_with Announcement.all
    respond_with Announcement.not_seen_not_expired(@user.id)
  end
  
  def create
    @announcement = Announcement.new(announcement_params)
    
    if @announcement.save
      render json: { :msg => "Announcement Created" }, status: :created
    else
      render json: @announcement.errors, status: :unprocessable_entity
    end
    
  end
  
  def mark_as_seen
    @announcement.seen_announcements.create(user_id: @user.id)
    render json: { :msg => "Announcement Marked as seen" }, status: :ok
  end
  
  
  private

    def set_announcement
      an_id = params[:id] || params[:announcement_id]
      @announcement = Announcement.find(an_id)
    end
    
    def set_user
      u_id = params[:user_id] || params[:announcement][:user_id]
      @user = User.find(u_id)
    end

    def record_not_found(error)
      render :json => {:error => error.message}, :status => :not_found
    end

    def handle_exception(error)
      render :json => {:error => error.inspect}, :status => :bad_request
    end

    
    def announcement_params
      params.require(:announcement).permit(:expiration_date, :text, :user_id)
    end
  
end
