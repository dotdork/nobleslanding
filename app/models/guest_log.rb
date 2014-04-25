class GuestLog < ActiveRecord::Base
  
  def self.all_desc
    return GuestLog.order('in_at DESC')
  end
  
  def self.all_asc
    return GuestLog.order('in_at ASC')
  end
end
