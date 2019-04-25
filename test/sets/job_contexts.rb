module Contexts
  module JobContexts
     def create_jobs
      @mixer = FactoryBot.create(:job, name: "Mixing products", active:false)
      @cleaner = FactoryBot.create(:job, name: "Cleaning machines", active:true)
      @salesman = FactoryBot.create(:job, name: "Selling Icecream ", active:true)
    end
    
    def remove_jobs
      @mixer.destroy
      @cleaner.destroy
      @salesman.destroy
    end

  end
end