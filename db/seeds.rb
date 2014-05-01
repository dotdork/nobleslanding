puts "********Seeding Data Start************"

admin_remove = User.find_by(email: "dotdork@gmail.com")
if admin_remove
  admin_remove.destroy
end

admin_remove = User.find_by(email: "admin@diddsdev.com")
if admin_remove
  admin_remove.destroy
end

admin = User.create(name: "Didds",
                    email: "admin@diddsdev.com",
                    password: "admin123",
                    password_confirmation: "admin123",
                    relation: "Family")

if admin.errors.blank?
    puts "***User #{admin.name} created ***"
else
    puts "admin user failed to create due to below reasons:"
    admin.errors.each do |x, y|
       puts"#{x} #{y}" # x will be the field name and y will be the error on it
     end
end

puts "********Seeding Data End************"