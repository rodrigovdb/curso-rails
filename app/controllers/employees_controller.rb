class EmployeesController < ApplicationController
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

  def edit
    @employee = Employee.find(params[:id])
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
    @employee = Employee.find(params[:id])
    @employee.destroy

    redirect_to employees_path, notice: 'Colaborador excluído com sucesso'
  end
end
