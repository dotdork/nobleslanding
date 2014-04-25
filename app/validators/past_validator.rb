class PastValidator < ActiveModel::EachValidator
  
  def validate_each(record, attribute, value)
    record.errors.add attribute, "is a date in the future" unless
         value <= Time.now.to_date
  end
end