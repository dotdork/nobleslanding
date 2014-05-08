puts "********Seeding Data Start************"

def check_errors(object)
  if object.errors.blank?
      puts "#{object.class.to_s.humanize} #{object.name} created"
  else
      puts "*** #{object.class.to_s.humanize} failed to create due to below reasons:"
      object.errors.each do |x, y|
         puts" - #{x} #{y}" # x will be the field name and y will be the error on it
       end
  end    
end


# populate User Categories
relations_list =
  { Disabled: "Disables Account and User cannot log in",
    Family: "Family member that is not a manager or member",
    Guest: "Invited Friends of Managers, Members or their Families",
    Manager: "Noble's Landing LLC Listed Managers",
    Member: "Adult Heirs (first Generation) to Noble's Landing LLC"
  }  

  relations_list.each do |name,desc|
    if name == 'Manager' || name == 'Disabled'
      admin_only = true
    else
      admin_only = false
    end
    if !relation = Relation.find_by(name: name)
      relation = Relation.create(name: name,
                                 description: desc,
                                 admin_only: admin_only)
      check_errors(relation) 
    end
  end

# Default Admin User
if !User.find_by(email: "admin@diddsdev.com")
  admin = User.create(name: "Didds",
                      email: "admin@diddsdev.com",
                      password: "admin123",
                      password_confirmation: "admin123",
                      admin: true,
                      relation_id: "Family")
                      
  check_errors(admin)                 
end


# Departure Checklist
if !Checklist.find_by(name: "Departure")
  departure = Checklist.new(name: "Departure",
                            description: "Please ensure the following is completed prior to ending your stay at Noble's Landing.",
                            checked: true)
                                
  departure.save

  check_errors(departure)
    
  departure_items = [ 
    { 
      name: "A/C & Refrigerator Filter Log, Closet Door",
      description: "Log it if you change filter"
    },
    { 
      name: "A/C Filter",
      description: "SUMMER: Check & Change first week of each month. WINTER: First of each month check filter and replace if it is dirty"
    },
    { 
      name: "Refrigerator Filter",
      description: "Change if filter light ON or every January, keep spare filters in Hall Closet"
    },
    { 
      name: "Thermostat",
      description: "Winter set Heat @ 45-50,  Summer set Cold @ 85"
    },
    { 
      name: "Floors and House",
      description: "swept, vacuum and clean for next guest"
    },  
    { 
      name: "Vacuum Cleaner",
      description: "In hall closet, Empty canister when finished"
    },  
    { 
      name: "Bathrooms",
      description: "wiped clean & dry tub and shower "
    },  
    { 
      name: "Shower door",
      description: "Closed"
    },  
    { 
      name: "Bath Curtain",
      description: "spread out to dry"
    },
    { 
      name: "Windows",
      description: "closed & locked (double check porch side)"
    },
    { 
      name: "Blinds",
      description: "check down and closed"
    },
    { 
      name: "Porch Furniture",
      description: "Check to ensure it does not tear screens"
    },  
    { 
      name: "Refrigerator",
      description: "check it is ON.  ** Remove Leftover Food,  it stinks after a short time"
    },  
    { 
      name: "Other Kitchen Appliances",
      description: "check they are all OFF"
    },  
    { 
      name: "Washer and Dryer",
      description: "contents emptied, folded & put away"
    },  
    { 
      name: "Water",
      description: "check all faucets OFF"
    },    
    { 
      name: "Flag",
      description: "take down and store in House"
    },    
    { 
      name: "Lights",
      description: "OFF (Interior & Exterior) "
    },    
    { 
      name: "Front Door",
      description: "locked, both locks "
    }, 
    { 
      name: "Key Safe",
      description: "return keys if used"
    },  
    { 
      name: "Septic Tank Light",
      description: "Verify 'OFF' (located West wall above septic field), if RED light is ON: Call Septic Company (phone # in back of Red Book)"
    },    
    { 
      name: "** Floods Lights and Under House Lights **",
      description: "Double check OFF when leaving, Bobby has turned them off too many times"
    },    
    { 
      name: "Main Water Valve",
      description: "ON"
    },    
    { 
      name: "Dog Droppings",
      description: "please check yard clean before you leave"
    },
    { 
      name: "Down Stairs",
      description: "clean up and store things in the Barn"
    },  
    { 
      name: "Barn",
      description: "Check electrical switch OFF (all lights should be OFF), then Lock Door"
    },    
    { 
      name: "Drive Safe",
      description: "we hope to see you soon"
    },                                                                                
  ]
                                
  seq = 0
  departure_items.each do |item|
    this_item = departure.checklist_items.new(item)
    this_item.seq = seq
    seq += 1
    this_item.save

    check_errors(this_item)
    
  end
                                                                                                                 
end

# Hurricane Checklist
if !Checklist.find_by(name: "Hurricane Preparations")
  hurricane = Checklist.new(name: "Hurricane Preparations",
                            description: "Please ensure the following is completed prior to any potential Hurricane threat to Noble's Landing.",
                            checked: true)
                                
  hurricane.save

  check_errors(hurricane)
    
  hurricane_items = [ 
    { 
      name: "General Clean Up",
      description: "Tie it down or bring it inside"
    },
    { 
      name: "Barn",
      description: "Bring as much as possible Inside the House 
      (No Gasoline, BBQ pits or other messy items)
      (Maybe Mac or Brett will store lawn mower)"
    },
    { 
      name: "Down Stairs",
      description: "Bring anything loose Down Stairs inside the house"
    },
    { 
      name: "Porch Furniture",
      description: "Bring Porch Furniture inside the house"
    },
    { 
      name: "Garden Hoses",
      description: "Bring in Garden Hoses (anything that leaks place inside a shower or tub)"
    },    
    { 
      name: "Furniture",
      description: "Move all furniture away from windows"
    },
    { 
      name: "Water Off",
      description: "Turn Water OFF at the street"
    },
    { 
      name: "Ice Maker",
      description: "Turn Ice Maker OFF (Valve under sink) and empty ice bucket"
    },
    { 
      name: "Food",
      description: "Consider taking home food out of refrigerator"
    },
    { 
      name: "Losing Electricity?",
      description: "Turn OFF refrigerator and leave doors propped OPEN.
      Place cup of open coffee in freezer and Refrigerator.
      Electrical Main Circuit Breaker Panel in Wash Room (Turn everything OFF)."
    },   
    { 
      name: "Front Door",
      description: "Lock Front Door (both Locks).  
      Cover Front Door with plywood cover (plywood is standing right rear corner of barn, 
      with a bag of screws, washers and a star bit: fasten into blue spots on front door trim boards)"
    },
    { 
      name: "Dolphin Sr",
      description: "Bring Dolphin back or store at Mac's or Brett's."
    },
                                                                                                
  ]
                                
  seq = 0
  hurricane_items.each do |item|
    this_item = hurricane.checklist_items.new(item)
    this_item.seq = seq
    seq += 1
    this_item.save

    check_errors(this_item)
    
  end
                                                                                                                 
end

# House Rules
if !Checklist.find_by(name: "House Rules")
  rules = Checklist.new(name: "House Rules",
                            description: "Please help us keep Noble's Landing looking Nice and New!",
                            checked: false)
                                
  rules.save

  check_errors(rules)
    
  rules_items = [ 
    { 
      name: "NO SITTING on the porch railing",
      description: "Its a very long Drop!"
    },
    { 
      name: "No Smoking Allowed",
      description: "in the house (or porch if windows open)."
    },
    { 
      name: "Please leave house CLEANER than you found it",
      description: ""
    },
    { 
      name: "Please help us conserve Electricity and Water",
      description: ""
    },      
    { 
      name: "Take all your Trash with you when you leave",
      description: ""
    },    
    { 
      name: "Do not remove any Beach House Furniture",
      description: ""
    },
    { 
      name: "Key Safe",
      description: "If you use it, replace keys and relock safe as soon as door is opened/closed."
    },
    { 
      name: "Guest Sign-In Sheet",
      description: "Sign in so we can keep a usage log for Tax Records.
      Guest Log and House Rules will be hanging in the Laundry room."
    },
    { 
      name: "Water",
      description: "Turn ON and OFF down Stairs at Water Cut-Off on rear piling (3rd from road)."
    },      
    { 
      name: "Flag",
      description: "Fly flag when you are there. Take down when you leave.  Store in Laundry Room or back of couch."
    },      
    { 
      name: "Family Lockers",
      description: "Use as you see fit. It is your private space (honor other's privacy)."
    },
    { 
      name: "Pets",
      description: "We love our pets but let's also respect of others.
      The porch will have a kid's gate and provide a safe outside area for pets.
      If they have to be in the house they should NEVER be on any furniture.   
      Please provide them a doggie bed or kennel for nights and bad weather."
    },
    { 
      name: "Wood Floors -Standing water on joints can cause joints to buckle",
      description: "After unloading your ice chests store them outside on the porch (condensation).
      No WET clothes or bathing suits allowed on floors or furniture in House.
      If you get water on floors please wipe up as soon as possible.
      Do not mop floors with water, if you use water to clean up stickiness please dry!"
    },
    { 
      name: "Bathroom Tub and Shower",
      description: "Fiberglass, DO NOT CLEAN with abrasive cleaners.
      Towel dry Tub, Shower and Shower Door before you leave. 
      Open shower door and spread out tub curtain before you leave.
      Leave clean towels in the bathrooms."
    },      
    { 
      name: "Thermostat",
      description: "Please enjoy A/C and Heating but help us conserve energy:
      Heat:  Set to 50 when you leave in the winter.
      A/C:   Set to 85 when you leave in the summer."
    }, 
    { 
      name: "Beds and Linens -Please do not sleep on beds without using bed linens",
      description: "Wash, Dry and Return bed linens to storage chests in each room.
      No pets on the beds, Kennel or fix them a bed on the floor. "
    },      
    { 
      name: "Lights",
      description: "House has enough lights to light up Pt. Bolivar, please use wisely.
      Use outside lights as needed then Turn Off (Good Neighbor Policy).    
      Use Spot Lights sparingly and then TURN OFF (Good Neighbor Policy).    
      The Under House Lights are difficult to replace, please help conserve.
      Note: Under house lights will be replaced by younger generation as needed."
    },      
    { 
      name: "Kitchen Counters",
      description: "Wipe and towel dry Granite counters before you leave. 
      Only use special granite cleaners or water."
    },
    { 
      name: "DO NOT PUT FOOD DOWN the DRAIN",
      description: "no disposal"
    },
    { 
      name: "Refrigerator",
      description: "DO NOT leave your perishables in the refrigerator when you leave."
    },
    { 
      name: "Microwave",
      description: "Make sure all food is removed and it has been wiped clean."
    },      
    { 
      name: "Dishwasher",
      description: "Wash, Dry and put away dishes before you leave."
    }, 
    { 
      name: "Washer and Dryer",
      description: "Clean Dryer Vent each cycle.  Folder and put everything away."
    },      
    { 
      name: "General",
      description: "Typically everyone replaces staples as they use them. 
      If a permanent item needs to be added/replaced for Nobles Landing then adjust amount 
      'Amount Paid' from Nightly Fees (if in doubt call someone).  
      Obviously this will be a learning experience for all of us.  
      We want everyone to have lots of FUN but Please be RESPONSIBLE!"
    },   
    { 
      name: "HAVE FUN BE SAFE! REMEMBER TOO MUCH SUN IS NO FUN!!! ",
      description: ""
    },          
                                                                                                                    
  ]
                                
  seq = 0
  rules_items.each do |item|
    this_item = rules.checklist_items.new(item)
    this_item.seq = seq
    seq += 1
    this_item.save

    check_errors(this_item)
    
  end
                                                                                                                 
end


puts "********Seeding Data End************"