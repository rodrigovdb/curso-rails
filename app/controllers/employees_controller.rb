class EmployeesController < ApplicationController
  before_action :set_employee,  only: [:show, :edit, :update, :destroy]

  def index
    @employees = Employee.includes(:sector).order(:name)
  end

  def show
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

  def edit
  end

  def update
    @employee             = Employee.find(params[:id])
    @employee.name        = params[:employee][:name]
    @employee.birth_date  = params[:employee][:birth_date]
    @employee.sex         = params[:employee][:sex]
    @employee.sector_id   = params[:employee][:sector_id]

    if @employee.valid?
      @employee.save
      redirect_to employees_path, notice: 'Colaborador atualizado com sucesso'
    else
      render :edit
    end
  end

  def destroy
    @employee.destroy

    redirect_to employees_path, notice: 'Colaborador excluído com sucesso'
  end

  private

  def set_employee
    @employee = Employee.find(params[:id])
  end
end
