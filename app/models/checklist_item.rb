class ChecklistItem < ActiveRecord::Base
  validates :name, :description, presence: true
  validates :seq, presence: true, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  
  belongs_to :checklist
  
  # resequence order
  def self.resequence
    s = 0
    ChecklistItem.order(:seq).each do |item|
      item.seq = s
      item.save
      s += 1
    end
  end
  
  # move item up in ordered list
  def moveup
    if self.seq == 0
      return true
    end
    
    one_up = ChecklistItem.find_by(seq: self.seq-1, checklist_id: self.checklist_id)
    one_up.seq = self.seq
    self.seq -= 1
    
    if self.save && one_up.save
      return true
    else
      return false
    end 
  end
  
  # move item down in ordered list
  def movedown
    if self == ChecklistItem.get_last(self.checklist_id)
      return true
    end
    
    one_down = ChecklistItem.find_by(seq: self.seq+1, checklist_id: self.checklist_id)
    one_down.seq = self.seq
    self.seq += 1
    
    if self.save && one_down.save
      return true
    else
      return false
    end     
  end

  def self.get_last(cid)
    item = ChecklistItem.where(checklist_id: cid).order('seq DESC').first()
    if item
      return item
    else
      return false
    end
  end
end
