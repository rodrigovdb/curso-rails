module ApplicationHelper
  def ajusta_data(date)
    return if date.nil?

    date.strftime '%d/%m/%Y'
  end
end
