class EmployeeMailer < ApplicationMailer
  def employees_email(user)
    @employees  = Employee.includes(:sector).order(:name)
    @user       = user
    @url        = 'http://example.com/login'

    mail(to: @user.email, subject: 'Colaboradores cadastrados')
  end

  def cron_mail
    @employees  = Employee.includes(:sector).order(:name)
    @user       = User.first

    mail(to: "#{@user.email}", subject: 'Colaboradores cadastrados') do |format|
      format.html { render 'employees_email' }
    end
  end
end
