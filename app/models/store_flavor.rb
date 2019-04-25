class StoreFlavor < ApplicationRecord
      belongs_to :store
      belongs_to :flavor

      scope :for_manager,  ->(manager_id) { where("store_id in (?)", Store.for_employee(manager_id)).select("store_id") }

end
