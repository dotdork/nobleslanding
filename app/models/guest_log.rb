class GuestLog < ActiveRecord::Base
  validates :name, :log, presence: true
  validates :in_at, past: true
  validates :rating, inclusion: { in: 1..10 }
  
  validate :validate_in_before_out

  def self.all_desc
    return GuestLog.order('in_at DESC')
  end
  
  def self.all_asc
    return GuestLog.order('in_at ASC')
  end
  
  private
  
  def validate_in_before_out
      if in_at && out_at
        errors.add(:out_at, "is before check in date") if out_at < in_at
      end
  end
end
