class Wagon
  include CompanyName
  
  attr_reader :type, :name

  def initialize(type)
    @type = type
    @name = nil
  end
end