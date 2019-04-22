module Contexts
  module UserContexts
    # Context for users 
    def create_users
      @eduser = FactoryBot.create(:user)
      @cindyuser = FactoryBot.create(:user, employee: @cindy, email: "ccrawford@gmail.com", password_digest: "anotherpass")
      @ralphuser = FactoryBot.create(:user, employee: @ralph, email: "rwilson@gmail.com", password_digest: "reaper127")
      @benuser = FactoryBot.create(:user, employee: @ben, email: "bennn@gmail.com", password_digest: "samsam1099")
    end
    
    def remove_users
      @eduser.destroy
      @cindyuser.destroy
      @ralphuser.destroy
      @benuser.destroy
    end
  end
end