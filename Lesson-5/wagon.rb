# module CompanyName
#   def get_name
#     puts 'Имя не задано' unless @name

#     puts @name
#   end

#   def set_name(name)
#     @name = name
#   end
# end

class Wagon
  include CompanyName
  
  attr_reader :type, :name

  def initialize(type)
    @type = type
    @name = nil
  end
end