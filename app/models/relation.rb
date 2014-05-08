class Relation < ActiveRecord::Base
  has_many :user
  validates :name, presence: true 
  
  def disabled?
    name == 'Disabled'
  end
end
