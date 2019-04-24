class ApplicationController < ActionController::Base
  helper_method :current_employee
  def current_employee
    if session[:employee_id]
      @current_employee ||= Employee.find(session[:employee_id])
    else
      @current_employee = nil
    end
  end
end
