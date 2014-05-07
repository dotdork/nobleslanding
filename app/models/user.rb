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

  
  # Authentication Methods   
  def self.authenticate_local(email, password)
    user = User.find_by(email: email)
    user && user.authenticate(password)
  end 
  
  def self.authenticate_facebook(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)  
      user.email = auth.info.email  
      if user.new_record?
        user.relation = 'Disabled'
        user.admin = false
        user.password = 'bogus'
        user.password_confirmation = 'bogus'
      end
      
      user.save!
    end
  end
  
  
  def local?
    provider == 'local'
  end

  def admin_s
    if admin
      "Admin"
    else
      "Standard"
    end
  end
end
