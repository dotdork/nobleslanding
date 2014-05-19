class ChecklistItem < ActiveRecord::Base
  before_create :set_sequence
  
  validates :name, presence: true
  
  belongs_to :checklist
  
  # resequence order
  def self.resequence
    puts "Resequencing checklist items"
    ChecklistItem.uniq.pluck(:checklist_id).each do |cid|
      s = 0
      ChecklistItem.where(checklist_id: cid).order(:seq).each do |item|
        item.seq = s
        item.save
        s += 1
      end          
    end
  end
  
  # move item up in ordered list
  def moveup
    if self.seq == 0
      return true
    end
    
    one_up = ChecklistItem.find_by(seq: self.seq - 1, checklist_id: self.checklist_id)
    one_up.seq = self.seq
    self.seq -= 1
    
    self.save && one_up.save
  end
  
  # move item down in ordered list
  def movedown
    if self == ChecklistItem.get_last(self.checklist_id)
      return true
    end
    
    one_down = ChecklistItem.find_by(seq: self.seq + 1, checklist_id: self.checklist_id)
    one_down.seq = self.seq
    self.seq += 1
    
    self.save && one_down.save
  end

  def self.get_last(cid)
    item = ChecklistItem.where(checklist_id: cid).order(:seq).last()
    if item
      return item
    else
      return false
    end
  end

  private
  
      def set_sequence
        puts "Setting Sequence ---------------------------------------------------------------------------------------"
        if last_seq = ChecklistItem.where(checklist_id: self.checklist_id).order(:seq).last()
          self.seq = last_seq.seq + 1
        else
          self.seq = 0
        end
      end
end
