class EmployeeMailer < ApplicationMailer
  def employees_email(user)
    @employees  = Employee.includes(:sector).order(:name)
    @user       = user
    @url        = 'http://example.com/login'

    mail(to: @user.email, subject: 'Colaboradores cadastrados')
  end
end
