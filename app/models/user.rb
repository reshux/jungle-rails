class User < ActiveRecord::Base
    has_secure_password

    has_many :reviews

    validates_uniqueness_of :email, case_sensitive: false, presence: true
    validates :password, presence: true
    validates :password, length: { minimum: 6 }
    validates :password_confirmation, presence: true
    validates :first_name, :last_name, presence: true
    validates :email, email: true
  
    def self.authenticate_with_credentials(email, password)
        user = User.find_by_email(email)
        if user && user.authenticate(password)
            user
        else
            nil
        end
    end
  
end
