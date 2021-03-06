class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update, :destroy]
  wrap_parameters :user, include: [:email, :password]

  # GET /employees
  # GET /employees.json

  def index
     @employee = current_employee
    if @employee !=nil then
      if @employee.role == "admin"
         @employees = Employee.all
      elsif @employee.role == "manager"
          #@employees = Employee.for_manager(@employee.id)
          @employees = Employee.all
      end
    end
  end
  
  
 
  
  def active
    @employees = Employee.active.alphabetical.paginate(:page => params[:page]).per_page(10)
  end
  
  def inactive
    @employees = Employee.inactive.alphabetical.paginate(:page => params[:page]).per_page(10)
  end

  # GET /employees/1
  # GET /employees/1.json
  def show
  end

  # GET /employees/new
  def new
    @employee = Employee.new
    @employee.build_user
  end

  # GET /employees/1/edit
  def edit
  end

  # POST /employees
  # POST /employees.json
  def create
    @employee = Employee.new(employee_params)
    
    respond_to do |format|
      if @employee.save
        session[:employee_id] = @employee.id
        format.html { redirect_to @employee, notice: 'Employee was successfully created'}
        format.json { render :show, status: :created, location: @employee }
        
      else
        format.html { render :new }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employees/1
  # PATCH/PUT /employees/1.json
  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to @employee, notice: 'Employee was successfully updated.' }
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html { render :edit }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1
  # DELETE /employees/1.json
  def destroy
    @employee.destroy
    respond_to do |format|
      format.html { redirect_to employees_url, notice: 'Employee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      params.require(:employee).permit(:first_name, :last_name, :ssn, :date_of_birth, :phone, :role, :active,  user_attributes: [:id, :email, :password])
    end
end
