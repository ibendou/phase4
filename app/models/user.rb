class User < ApplicationRecord
    belongs_to :employee
    has_secure_password
end
