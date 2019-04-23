module Contexts
  module FlavorContexts
    def create_flavors
      @vanilla = FactoryBot.create(:flavor, name: "Vanilla", active:false)
      @chocolate = FactoryBot.create(:flavor, name: "Chocolate", active:false)
      @lemon = FactoryBot.create(:flavor, name: "Lemon ", active:true)
    end
    
    def remove_flavors
      @vanilla.destroy()
      @chocolate.destroy()
      @lemon.destroy()
    end
  end
end