require 'spec_helper'




describe "Viewing the list of guest logs" do
  
  it "shows the movies" do
    
    log1 = GuestLog.create(name: "Pat Johnson",
                          log: "Had a great time!  It was a very long stay",
                          in_at: "2008-05-02",
                          out_at: "2008-06-02")
                          
    log2 = GuestLog.create(name: "Cheryl Myers",
                          log: "It rained the whole time.  So lame.",
                          in_at: "2009-05-02",
                          out_at: "2009-05-03")
                          
    log3 = GuestLog.create(name: "Robert Johnson",
                          log: "I was on the train to bangkok, aboard the thailand express.",
                          in_at: "2010-05-02",
                          out_at: "2010-06-02")
                          
    visit 'http://localhost:3000/guest_logs'
  
    expect(page).to have_text("3 Guest Logs for Noble's Landing")
  end
  
end