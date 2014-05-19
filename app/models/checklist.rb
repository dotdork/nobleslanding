class Checklist < ActiveRecord::Base
  before_create :check_login_val
  before_save :check_login_val
   
  validates :name, presence: true
  
  has_many :checklist_items, dependent: :destroy

  self.per_page = 15
  
  private
    def check_login_val
      # must require login if requiring manager
      if self.manager_only
        self.require_login = true
      end
    end
  
end
