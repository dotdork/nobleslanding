class HomeController < ApplicationController
  before_action :require_noble, only: [:calendar]
    
  def calendar

  end

end
