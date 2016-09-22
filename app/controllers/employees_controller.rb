class EmployeesController < ApplicationController
  before_action :set_employee,  only: [:show, :edit, :update, :destroy]

  def index
    # Atribui à @search_filters o conteúdo dos parâmetros informados ou inicializa um hash vazio.
    @search_filters     = params[:filters] || {}
    employees           = Employee

    unless @search_filters.nil?
      employees = employees.partial_name(@search_filters[:name])          unless @search_filters[:name].blank?
      employees = employees.where(sector_id: @search_filters[:sector_id]) unless @search_filters[:sector_id].blank?
    end

    @employees = employees.includes(:sector).order(:name)
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

  def send_by_mail
    EmployeeMailer.employees_email(current_user).deliver_now

    redirect_to employees_path, notice: 'Listagem enviada por email com sucesso'
  end

  private

  def set_employee
    @employee = Employee.find(params[:id])
  end
end
