module CompanyName
  def get_name
    puts 'Имя не задано' unless @name

    puts @name
  end

  def set_name(name)
    @name = name
  end
end
