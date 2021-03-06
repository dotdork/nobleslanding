class User < ActiveRecord::Base
  has_secure_password
  belongs_to :relation

  # validations  
  validates :name, presence: true
  validates :email, presence: true,
                    format: /\A\S+@\S+\z/,
                    uniqueness: { case_sensitive: false, :if => :local? }   

  self.per_page = 15
          
  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
                 
  # Authentication Methods   
  def self.authenticate_local(email, password)
    user = User.find_by(email: email, provider: 'local')
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
        user.relation_id = 'Disabled'
        user.admin = false
        user.password = 'bogus'
        user.password_confirmation = 'bogus'
      end     
      user.save!
    end
  end
  
  def self.authenticate_google(auth)
    puts auth.to_s
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)  
      user.email = auth.info.email  
      if user.new_record?
        user.relation_id = 'Disabled'
        user.admin = false
        user.password = 'bogus'
        user.password_confirmation = 'bogus'
      end     
      user.save!
    end
  end
 
  def self.authenticate_google_refresh(auth)
    puts auth.to_s
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      # set refresh token as password
      #user.password = auth.credentials.refresh_token
      #user.password_confirmation = auth.credentials.refresh_token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)  
      user.email = auth.info.email  
      if user.new_record?
        user.relation_id = 'Disabled'
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

  def disabled?
    relation_id == 'Disabled'
  end
  
  def admin_s
    if admin
      "Admin"
    else
      "Standard"
    end
  end
  
  def noble?
    name == 'Nobles Landing'
  end
  
  def manager?
    relation_id = 'Manager'
  end
  
  def provider_s
    case provider
    when 'google_oauth2'
      'google'
    when 'google_refresh'
      'Do Not Edit'
    else
      provider
    end
  end
end
