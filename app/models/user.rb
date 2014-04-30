class User < ActiveRecord::Base
  has_secure_password

  # constants
  RELATIONS = [ "Owner", "Family", "Friend" ]
  RELATIONS_ADMIN = RELATIONS + [ "Disabled" ] 

  # validations  
  validates :name, presence: true
  validates :email, presence: true,
                    format: /\A\S+@\S+\z/,
                    uniqueness: { case_sensitive: false }
               
  validates :relation, presence: true, inclusion: { in: RELATIONS_ADMIN }

    
  # Methods
  RELATIONS_ADMIN.each_with_index do |meth, index|
    define_method("#{meth.downcase}?") { relation == meth }
  end
   
  def self.authenticate(email, password)
    user = User.find_by(email: email)
    user && user.authenticate(password)
  end 

  def admin_s
    if admin
      "Admin"
    else
      "Standard"
    end
  end
end
