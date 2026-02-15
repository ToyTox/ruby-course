class Wagon
  include CompanyName
  include Validator
  
  attr_reader :type

  def initialize(type)
    @type = type
    validate!
    valid?
  end

  protected

  def validate!
    raise "Имя не может быть nil" if type.nil?
    raise "Имя не может быть пустым" if type.empty?
    true
  end
end