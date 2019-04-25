class ApplicationController < ActionController::Base
  helper_method :current_employee
  before_action :require_login, except: :login_path
  
  def current_employee
    if session[:employee_id]
      @current_employee ||= Employee.find(session[:employee_id])
    else
      @current_employee = nil
    end
  end

  private
  def require_login
    if current_employee.nil? then
      #redirect_to login_path
    end
  end
end
