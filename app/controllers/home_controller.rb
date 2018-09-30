class HomeController < ApplicationController
  def home
    if user_signed_in?
      redirect_to announcements_path
    end
    
  end
end
