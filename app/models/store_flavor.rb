class StoreFlavor < ApplicationRecord
      belongs_to :falvors
      has_many :stores
      
end
