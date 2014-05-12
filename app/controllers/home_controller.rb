class HomeController < ApplicationController
  before_action :require_signin, only: [:calendar]
    
  def calendar
    
  end

end
