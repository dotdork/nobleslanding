class HomeController < ApplicationController
  before_action :require_noble, only: [:calendar]
    
  def calendar
    session[:noble_id] = nil
  end

end
