class Wagon
  include CompanyName
  
  attr_reader :type, name

  def initialize(type, company_name)
    @type = type
    @name = company_name
  end
end