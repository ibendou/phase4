class User < ApplicationRecord
    
   
    has_secure_password
    

    belongs_to(:employee)
    validates_presence_of :email
    validates_uniqueness_of :email
    validates_presence_of :password_digest, on: :create

    
    validates_format_of :email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "should have a valid email address", allow_blank: true

  


end
