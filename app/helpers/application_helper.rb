module ApplicationHelper
  def ajusta_data(date)
    date.strftime '%d/%m/%Y'
  end
end
