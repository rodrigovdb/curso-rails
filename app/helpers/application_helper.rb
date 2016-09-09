module ApplicationHelper
  def ajusta_data(date)
    return date.strftime('%d/%m/%Y')
  end
end
