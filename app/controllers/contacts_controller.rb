class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]
  before_action :set_employee,  only: [:new, :create, :destroy]

  # GET /contacts
  # GET /contacts.json
  def index
    @contacts = Contact.all
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
  end

  # GET /contacts/new
  def new
    @contact          = Contact.new
    @contact.employee = @employee
  end

  # GET /contacts/1/edit
  def edit
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.new(contact_params)
    @contact.employee = @employee

    if @contact.save
      redirect_to @employee, notice: 'Contact was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /contacts/1
  # PATCH/PUT /contacts/1.json
  def update
    if @contact.update(contact_params)
      redirect_to @contact.employee, notice: 'Contact was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact.destroy

    redirect_to @employee, notice: 'Contact was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    def set_employee
      @employee = Employee.find(params[:employee_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:employee_id, :contact_type_id, :phone_number)
    end
end
