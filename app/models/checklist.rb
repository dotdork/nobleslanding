class Checklist < ActiveRecord::Base
  validates :name, presence: true
  
  has_many :checklist_items, dependent: :destroy

  self.per_page = 15
  
end
