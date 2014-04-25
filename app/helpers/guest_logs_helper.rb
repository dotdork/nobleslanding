module GuestLogsHelper
  
  def get_duration(guest_log)
    if guest_log.in_at == guest_log.out_at
      '1 day'
    else
      distance_of_time_in_words(guest_log.in_at,guest_log.out_at)
    end
  end  
end
