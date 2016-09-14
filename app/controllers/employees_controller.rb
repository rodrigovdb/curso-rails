class EmployeesController < ApplicationController
  def index
    @employees = Employee.includes(:sector).order(:name)
  end

  def show
    @employee = Employee.find(params[:id])
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee             = Employee.new
    @employee.name        = params[:employee][:name]
    @employee.birth_date  = params[:employee][:birth_date]
    @employee.sex         = params[:employee][:sex]
    @employee.sector_id   = params[:employee][:sector_id]

    if @employee.valid?
      @employee.save
      redirect_to employees_path, notice: 'Colaborador cadastrado com sucesso'
    else
      render :new
    end
  end

end
